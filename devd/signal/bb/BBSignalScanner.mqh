//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+
#property strict

#include <devd/signal/SignalScanner.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

class BBSignalScanner : public SignalScanner
{

protected:
    double itsInnerSD;
    double itsOuterSD;
    int itsPeriod;

public:
    SignalResult scan()
    {

        SignalResult result = {GO_NOTHING, -1.0, -1.0, -1.0};

        log(StringFormat("Ask :%f, Bid :%f", Ask, Bid));
        log(StringFormat("itsPeriod :%f, itsInnerSD :%f, itsOuterSD:%f", itsPeriod, itsInnerSD, itsOuterSD));
        double innerMain = iBands(NULL, PERIOD_CURRENT, itsPeriod, itsInnerSD, 0, PRICE_CLOSE, MODE_MAIN, 0);
        double innerUpper = iBands(NULL, PERIOD_CURRENT, itsPeriod, itsInnerSD, 0, PRICE_CLOSE, MODE_UPPER, 0);
        double innerLower = iBands(NULL, PERIOD_CURRENT, itsPeriod, itsInnerSD, 0, PRICE_CLOSE, MODE_LOWER, 0);
        log(StringFormat("innerMain :%f, innerUpper :%f, innerLower:%f", innerMain, innerUpper, innerLower));

        double outerMain = iBands(NULL, PERIOD_CURRENT, itsPeriod, itsOuterSD, 0, PRICE_CLOSE, MODE_MAIN, 0);
        double outerUpper = iBands(NULL, PERIOD_CURRENT, itsPeriod, itsOuterSD, 0, PRICE_CLOSE, MODE_UPPER, 0);
        double outerLower = iBands(NULL, PERIOD_CURRENT, itsPeriod, itsOuterSD, 0, PRICE_CLOSE, MODE_LOWER, 0);
        log(StringFormat("outerMain :%f, outerUpper :%f, outerLower:%f", outerMain, outerUpper, outerLower));

        if (Ask < innerLower)
        {
            result.go = GO_LONG;
            result.entry = Ask;
            result.stopLoss = outerLower;
            result.takeProfit = innerMain;
        }
        if (Bid > innerUpper)
        {
            result.go = GO_SHORT;
            result.entry = Bid;
            result.stopLoss = outerUpper;
            result.takeProfit = innerMain;
        }

        return result;
    }

    int magicNumber()
    {
        return 9;
    }

    BBSignalScanner(double innerSD, double outerSD, int period)
    {
        itsInnerSD = innerSD;
        itsOuterSD = outerSD;
        itsPeriod = period;
    }
};

//+------------------------------------------------------------------+

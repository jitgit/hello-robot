//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+
#property strict
#include <devd/signal/bb/BBSignalScanner.mqh>
#include <devd/order/OrderManager.mqh>

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

class RiskManager
{

public:
    double optimalLotSize(double maxRiskPerc, int maxLossInPips)
    {
        double accBalance = AccountBalance();
        double accEquity = AccountEquity();
        double maxLoss = (accBalance * maxRiskPerc);
        int lotSize = MarketInfo(NULL, MODE_LOTSIZE);
        double tickValue = MarketInfo(NULL, MODE_TICKVALUE);
        double tickSize = MarketInfo(NULL, MODE_TICKSIZE);

        tickValue = Digits <= 3 ? tickValue / 100 : tickValue; //handling JPY

        string accountCurrency = AccountCurrency();
        double maxLossInQuoteCurrency = maxLoss / tickValue;

        double optimalLotSize = NormalizeDouble(maxLossInQuoteCurrency / (maxLossInPips * GetPipValueFromDigits()) / lotSize, 2);
        log(StringFormat("Balance :%f, Equity: %f, MaxLoss :%f, maxLossInPips:%d", accBalance, accEquity, maxLoss, maxLossInPips));
        log(StringFormat("AccountCurrency :%s, _Symbol: %s Tick (Value :%f , Size :%f )", accountCurrency, _Symbol, tickValue, tickSize));
        log(StringFormat("maxLossInQuoteCurrency :%f, optimalLotSize: %f, SSSS :%f", maxLossInQuoteCurrency, optimalLotSize, maxLoss));
        return optimalLotSize;
    }

    double optimalLotSize(double maxRiskPerc, double entryPrice, double stopLoss)
    {
        int maxLossInPips = MathAbs(entryPrice - stopLoss) / GetPipValueFromDigits();
        return optimalLotSize(maxRiskPerc, maxLossInPips);
    }

public:
    RiskManager()
    {
    }
};

//+------------------------------------------------------------------+

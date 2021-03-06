//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+
#property strict

class RiskManager
{
protected:
    double itsRiskPercentage;

public:
    double optimalLotSize(double maxRiskPerc, int maxLossInPips)
    {
        double accBalance = AccountBalance();
        string accCurr = AccountCurrency();
        double accEquity = AccountEquity();
        double maxLoss = accEquity * maxRiskPerc;
        double lotSize = MarketInfo(NULL, MODE_LOTSIZE);
        double tickValue = MarketInfo(NULL, MODE_TICKVALUE);
        double tickSize = MarketInfo(NULL, MODE_TICKSIZE);

        tickValue = Digits <= 3 ? tickValue / 100 : tickValue; //handling JPY
        log(StringFormat("Tick (Value :%f, Size :%f)", tickValue, tickSize));
        if (tickValue != 0)
        {

            double maxLossInQuoteCurrency = maxLoss / tickValue;

            double optimalLotSize = NormalizeDouble(maxLossInQuoteCurrency / (maxLossInPips * GetPipValueFromDigits()) / lotSize, 2);
            log(StringFormat("Balance :%+.0f %s, Equity: %+.0f %s, MaxLoss :%+.0f %s, maxLossInPips:%d", accBalance, accCurr, accEquity, accCurr, maxLoss, accCurr, maxLossInPips));

            log(StringFormat("RISK_ALLOWED: %f, maxLossInQuoteCurrency :%f, optimalLotSize: %f", maxRiskPerc, maxLossInQuoteCurrency, optimalLotSize));
            return optimalLotSize;
        }
        else
        {
            warn("Tick Value is zero");
            return 0;
        }
    }

    double optimalLotSize(double maxRiskPerc, double entryPrice, double stopLoss)
    {
        int maxLossInPips = MathAbs(entryPrice - stopLoss) / GetPipValueFromDigits();
        return optimalLotSize(maxRiskPerc, maxLossInPips);
    }

    double optimalLotSize(double entryPrice, double stopLoss)
    {
        return optimalLotSize(itsRiskPercentage, entryPrice, stopLoss);
    }

public:
    RiskManager(double riskPercentage = 0.02)
    {
        itsRiskPercentage = riskPercentage;
    }
};

//+------------------------------------------------------------------+

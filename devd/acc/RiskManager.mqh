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
        double accEquity = AccountEquity();
        double maxLoss = accEquity * maxRiskPerc;
        double lotSize = MarketInfo(NULL, MODE_LOTSIZE);
        double tickValue = MarketInfo(NULL, MODE_TICKVALUE);
        double tickSize = MarketInfo(NULL, MODE_TICKSIZE);

        tickValue = Digits <= 3 ? tickValue / 100 : tickValue; //handling JPY

        double maxLossInQuoteCurrency = maxLoss / tickValue;

        double optimalLotSize = NormalizeDouble(maxLossInQuoteCurrency / (maxLossInPips * GetPipValueFromDigits()) / lotSize, 2);
        log(StringFormat("Balance :%f, Equity: %f, MaxLoss :%f, maxLossInPips:%d", accBalance, accEquity, maxLoss, maxLossInPips));
        log(StringFormat("Tick (Value :%f, Size :%f)", AccountCurrency(), _Symbol, tickValue, tickSize));
        log(StringFormat("RISK_ALLOWED: %f, maxLossInQuoteCurrency :%f, optimalLotSize: %f",maxRiskPerc, maxLossInQuoteCurrency, optimalLotSize));
        return optimalLotSize;
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

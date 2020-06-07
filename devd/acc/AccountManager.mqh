//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+
#property strict

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class AccountManager
{

protected:
    double itsRiskPercentage;

public:
    void printAccountInfo()
    {
        debug(StringFormat("AccountCurrency :%s, _Symbol: %s", AccountCurrency(), _Symbol));
    }

public:
    AccountManager(double riskPercentage = 0.02)
    {
        itsRiskPercentage = riskPercentage;
    }
};

//+------------------------------------------------------------------+

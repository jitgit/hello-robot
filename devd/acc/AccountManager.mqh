//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+
#property strict

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#include <devd/acc/RiskManager.mqh>

class AccountManager
{

protected:
    double itsRiskPercentage;
    RiskManager *riskManager;

public:
    void printAccountInfo()
    {
        log(StringFormat("AccountCurrency :%s, _Symbol: %s", AccountCurrency(), _Symbol));        
    }

public:
    AccountManager(double riskPercentage = 0.02)
    {
        itsRiskPercentage = riskPercentage;
        riskManager = new RiskManager();
    }
};

//+------------------------------------------------------------------+

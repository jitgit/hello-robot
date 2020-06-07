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
    RiskManager *riskManager;

public:
    void printAccountInfo()
    {
        int maxLossInPips = 40; //TODO
        riskManager.optimalLotSize(0.02, maxLossInPips);
    }

public:
    AccountManager()
    {
        riskManager = new RiskManager();
    }
};

//+------------------------------------------------------------------+

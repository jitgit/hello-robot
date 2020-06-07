//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+
#property strict
#include <stderror.mqh>
#include <stdlib.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

class OrderManager
{

public:
    bool isTradingAllowed()
    {
        /*if(!IsTradeAllowed()) {
            // Alert("Auto Trading is disable for Expert Advisor");
            return false;

        } else {
            if(IsTradeAllowed(Symbol(), TimeCurrent())) {
                // Alert(StringFormat("Trading not allowed for %s during %s", Symbol(), TimeCurrent()));
                return false;
            }
        }*/
        return true;
    }

    void bookTrade(bool isLong, double entry, double stoploss, double takeProfit)
    {

        //TODO check that stoploss diff is great than STOP_LEVEL

        double lotSize = 0.01; //TODO use a strategy for lotsize
        if (isTradingAllowed())
        {
            int orderId = -1;
            if (isLong)
            {
                orderId = OrderSend(NULL, OP_BUYLIMIT, lotSize, entry, 10, stoploss, takeProfit, "Buy Order");
            }
            else
            {
                orderId = OrderSend(NULL, OP_SELLLIMIT, lotSize, entry, 10, stoploss, takeProfit, "Buy Order");
            }

            log("orderId: " + orderId);
            if (orderId < 0)
            {
                int error = GetLastError();
                log(StringFormat("ORDER REJECTED. Error :%d (%s)", error, ErrorDescription(error)));
            }
            else
                log("Order successful");
        }
        else
            log("Auto trading is not allowed, or trading hours not active");
    }

    int getTotalOrderByMagicNum(int magicNumber)
    {
        int openOrders = OrdersTotal();
        int result = 0;
        for (int i = 0; i < openOrders; i++)
        {
            if (OrderSelect(i, SELECT_BY_POS) == true)
            {
                if (OrderMagicNumber() == magicNumber)
                {
                    result++;
                }
            }
        }
        return result;
    }

public:
    OrderManager()
    {
    }
};

//+------------------------------------------------------------------+

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
        if (!IsTradeAllowed())
        {
            warn("Auto Trading is disable for Expert Advisor");
            return false;
        }
        else
        {
            if (IsTradeAllowed(Symbol(), TimeCurrent()))
            {
                warn(StringFormat("Trading not allowed for %s during %s", Symbol(), TimeCurrent()));
                return false;
            }
        }
        return true;
    }

    void bookTrade(bool isLong, double entry, double stoploss, double takeProfit, double lotSize, int magicNumber, int slippage = 10, string comment = "") //TODO use a strategy for slippage
    {

        //TODO check that stoploss diff is great than STOP_LEVEL
        if (isTradingAllowed())
        {
            long orderId = -1;
            if (isLong)
            {
                orderId = OrderSend(NULL, OP_BUYLIMIT, lotSize, entry, slippage, stoploss, takeProfit, "Buy Order");
            }
            else
            {
                orderId = OrderSend(NULL, OP_SELLLIMIT, lotSize, entry, slippage, stoploss, takeProfit, "Sell Order");
            }

            if (orderId < 0)
            {
                int error = GetLastError();
                log(StringFormat("ORDER ID(%d) REJECTED. Error: %d(%s)", orderId, error, ErrorDescription(error)));
            }
            else
                log(StringFormat("Order ID(%d), SUCCESSFUL", orderId));
        }
        else
        {
            log("Auto trading is not allowed, or trading hours not active");
        }
    }

    int getTotalOrderByMagicNum(int magicNumber, long &orderIds[])
    {
        int openOrders = OrdersTotal();
        int index = 0;
        for (int i = 0; i < openOrders; i++)
        {
            if (OrderSelect(i, SELECT_BY_POS) == true)
            {
                OrderPrint();
                if (OrderMagicNumber() == magicNumber)
                {
                    ArrayResize(orderIds, ArraySize(orderIds) + 1);
                    orderIds[index++] = OrderTicket();
                }
            }
        }
        return ArraySize(orderIds);
    }

public:
    OrderManager()
    {
    }
};

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+

#property strict

#include <devd/common.mqh>
#include <devd/account-utils.mqh>
#include <devd/signal/bb/BBSignalScanner.mqh>
#include <devd/order/OrderManager.mqh>
#include <devd/acc/AccountManager.mqh>

int MAX_ORDER_THREADHOLD = 1;

void main()
{
    SignalScanner *scanner = new BBSignalScanner(1, 4, 20);

    OrderManager *orderManager = new OrderManager();
    int currentOrdersByMagicNumber = orderManager.getTotalOrderByMagicNum(scanner.magicNumber());

    log(StringFormat("Magic Number(%d), MaxOrder(%d), Exiting(%d)", scanner.magicNumber(), MAX_ORDER_THREADHOLD, currentOrdersByMagicNumber));
    if (currentOrdersByMagicNumber > MAX_ORDER_THREADHOLD)
    {
        warn("Not scanning or booking orders any more.");
    }
    else
    {
        AccountManager *accountManager = new AccountManager();
        accountManager.printAccountInfo();
        RiskManager *riskManager = new RiskManager();

        PrintCurrencyInfo();
        SignalResult scan = scanner.scan();

        log("Scan Result: " + scan.str());
        if (scan.go == GO_LONG || scan.go == GO_SHORT)
        {
            bool isLong = scan.go == GO_LONG;
            double optimalLotSize = riskManager.optimalLotSize(scan.stopLoss, scan.takeProfit);
            orderManager.bookTrade(isLong, scan.entry, scan.stopLoss, scan.takeProfit, optimalLotSize);
        }
        else
        {
            log("NO SIGNAL FROM SCAN RESULT");
        }
    }
}
//+------------------------------------------------------------------+

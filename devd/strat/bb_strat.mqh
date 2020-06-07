//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+

#property strict

#include <devd/common.mqh>
#include <devd/AccountInfo.mqh>
#include <devd/signal/bb/BBSignalScanner.mqh>
#include <devd/order/OrderManager.mqh>
#include <devd/acc/AccountManager.mqh>

void main() {

    AccountManager *accountManager = new AccountManager();
    accountManager.printAccountInfo();

    PrintCurrencyInfo();

    SignalScanner *scanner = new BBSignalScanner(1, 4, 20);
    SignalResult scan = scanner.scan();
    OrderManager *orderManager = new OrderManager();
    int currentOrders = orderManager.getTotalOrderByMagicNum(scanner.magicNumber());
    log("currentOrders :" + currentOrders);

    log("Scan Result: " + scan.str());
    if (scan.go == GO_LONG || scan.go == GO_SHORT) {
        bool isLong = scan.go == GO_LONG;
        orderManager.bookTrade(isLong, scan.entry, scan.stopLoss, scan.takeProfit);
    } else {
        log("NO SIGNAL FROM SCAN RESULT");
    }

// log("algo.calculateSL() :" + algo.calculateSL(isLong));
// log("algo.calculateTP() :" + algo.calculateTP(isLong));
}
//+------------------------------------------------------------------+

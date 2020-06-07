//+------------------------------------------------------------------+
//|                                                 Jatin Patel DevD |
//|                                                 https://devd.com |
//+------------------------------------------------------------------+
#property strict

double STOP_LOSS_PERCENTAGE = 0.02;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PrintCurrencyInfo() {
    log(StringFormat("Price [%f, %f], TL:%dm , %f , _Digits: %d", Bid, Ask, _Period, _Point, _Digits));
    log(StringFormat("MinLot: %f SL Level: %f", MarketInfo(NULL, MODE_MINLOT), MarketInfo(NULL, MODE_STOPLEVEL)));
    log(StringFormat("Day Range - [%f , %f]", MarketInfo(NULL, MODE_LOW), MarketInfo(NULL, MODE_HIGH)));

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double GetPipValueFromDigits() {
    if(_Digits >= 4)
        return 0.0001;
    else
        return 0.01;
}
//+------------------------------------------------------------------+

import 'exchange.dart';
import 'exchange_store.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'ETH', 'LTC', 'SOL', 'BNB'];

class CoinData {
  ExchangeStore store = ExchangeStore();
  String today = DateTime.now().toString().substring(0, 10);

  Future getCoinData(String base, String quote) async {
    if (!store.setPreferences) {
      await store.initPref();
    }
    Exchange exchange = await store.getExchange(base, quote, today);
    return exchange.rate;
  }
}

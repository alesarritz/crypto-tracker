import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'exchange.dart';
import 'networking.dart';

enum Status { available, unavailable, old }

class ExchangeStore {
  late SharedPreferences prefs;
  bool setPreferences = false;
  Status status = Status.unavailable;
  NetworkHelper networkHelper = NetworkHelper();

  Future<void> initPref() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('exchanges') == null) {
      prefs.setStringList('exchanges', []);
    }
    setPreferences = true;
  }

  //Checks exchange presence:
  // - if not present adds it to the store
  // - if present but old updates it in the store
  // - if present does nothing
  Future<Exchange> getExchange(String base, String quote, time) async {
    //get the stored exchanges
    final List<String>? storedExchanges = prefs.getStringList('exchanges');

    if (storedExchanges != null) {
      Exchange exchange;
      int index = checkCurrencies(storedExchanges, base, quote, time);
      // Exchange already saved
      if (status == Status.available) {
        String value = storedExchanges[index];
        exchange = Exchange.fromJson(jsonDecode(value));
      }
      // Exchange saved in a  time < today
      else if (status == Status.old) {
        storedExchanges.remove(storedExchanges[index]);
        exchange = await networkHelper.makeRequest(quote, base);
        await addExchange(jsonEncode(exchange.toJson()), storedExchanges);
      }
      //Exchange not saved
      else {
        exchange = await networkHelper.makeRequest(quote, base);
        await addExchange(jsonEncode(exchange.toJson()), storedExchanges);
      }
      return exchange;
    } else {
      {
        throw 'Problem with the Exchange Store';
      }
    }
  }

  int checkCurrencies(
      List<String> storedExchanges, String base, String quote, String time) {
    int index = -1;
    for (String value in storedExchanges) {
      Exchange storedE = Exchange.fromJson(jsonDecode(value));
      if (storedE.asset_id_base == base && storedE.asset_id_quote == quote) {
        storedE.time.compareTo(time) < 0
            ? status = Status.old
            : status = Status.available;
        index = storedExchanges.indexOf(value);
      }
    }
    return index; //if there's an (available || old) exchange returns its index
  }

  Future<void> addExchange(
      String exchange, List<String> storedExchanges) async {
    storedExchanges.add(exchange);
    await prefs.remove('exchanges');
    await prefs.setStringList('exchanges', storedExchanges);
  }
}

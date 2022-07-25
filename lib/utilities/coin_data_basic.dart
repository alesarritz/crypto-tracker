import 'dart:convert';
import 'package:http/http.dart' as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'YOUR-API-KEY';

class CoinData {
  Future getCoinData(String selectedCurrency, String crypto) async {
    String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
    http.Response response = await http.get(Uri.parse(requestURL));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData['rate'];
    } else {
      throw 'Problem with the get request ${response.statusCode}';
    }
  }
}

/*

{
  "time": "2022-07-22T16:09:55.0000000Z",
  "asset_id_base": "BTC",
  "asset_id_quote": "GBP",
  "rate": 19438.062873052681603514100644
}

 */

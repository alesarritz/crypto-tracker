import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exchange.dart';

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'YOUR-API-KEY';

class NetworkHelper {
  Future<Exchange> makeRequest(String selectedCurrency, String crypto) async {
    String reqURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
    http.Response response = await http.get(Uri.parse(reqURL));

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      Map<String, dynamic> exchangeMap = decodedData;
      Exchange exchange = Exchange.fromJson(exchangeMap);
      return exchange;
    } else {
      throw 'Problem with the get request: ${response.statusCode}';
    }
  }
}

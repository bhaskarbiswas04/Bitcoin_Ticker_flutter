import 'dart:convert';
import 'package:http/http.dart' as http;

const apikey = 'F4730B30-521B-41ED-9A90-177960061165';
const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate';

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
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  //the following function gets the data from the CoinApi.io (external site).
  Future getCoinData(String selectedCurency) async {
    Map<String, int> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$coinApiURL/$crypto/$selectedCurency?apikey=$apikey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode >= 200) {
        var data = jsonDecode(response.body);
        double lastRate = data['rate'];
        cryptoPrices[crypto] = lastRate.toInt();
      } else {
        print(response.statusCode);
        throw 'Problem in getting Request';
      }
    }
    return cryptoPrices;
  }
}

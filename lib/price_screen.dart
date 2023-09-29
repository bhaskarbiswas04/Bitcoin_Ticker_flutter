import 'package:flutter/material.dart';
import 'coin_data.dart';

class priceScreen extends StatefulWidget {
  const priceScreen({super.key});

  @override
  State<priceScreen> createState() => _priceScreenState();
}

class _priceScreenState extends State<priceScreen> {
  String selectedCurrency = currenciesList.first;

//Creating a function which returns the
  List<DropdownMenuItem> getDropDownItems() {
    List<DropdownMenuItem<String>> getItemLists = [];

    for (String currency in currenciesList) {
      //a type of for loop in dart.
      var newItems = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      getItemLists.add(newItems);
    }

    return getItemLists;
  }

  Map<String, int> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    // isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                cryptoCurrency: 'BTC',
                value: isWaiting ? '?' : coinValues['BTC'],
                currentCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                value: isWaiting ? '?' : coinValues['ETH'],
                currentCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                value: isWaiting ? '?' : coinValues['LTC'],
                currentCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: const Color.fromARGB(255, 5, 103, 152),
            child: DropdownButton(
              value: selectedCurrency,
              items: getDropDownItems(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value!;
                  getData();
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    super.key,
    required this.cryptoCurrency,
    required this.value,
    required this.currentCurrency,
  });

  final String cryptoCurrency;
  final Object? value;
  final String currentCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $currentCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

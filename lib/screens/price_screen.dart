import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utilities/coin_data_advanced/coin_data_advanced.dart';
import 'dart:io' show Platform;
import '../utilities/cryptoButton.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  List<String> cryptoValue = [];

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        alignment: AlignmentDirectional.center,
        value: currency,
        child: Text(
          currency,
          style: const TextStyle(fontSize: 23.0),
        ),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      style: const TextStyle(color: bgColor),
      value: selectedCurrency,
      alignment: AlignmentDirectional.center,
      dropdownColor: Colors.white,
      iconEnabledColor: bgColor,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(
        currency,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 25.0),
      ));
    }

    return CupertinoPicker(
      backgroundColor: Colors.white,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency =
              pickerItems.elementAt(selectedIndex).data.toString();
        });
        getData();
      },
      children: pickerItems,
    );
  }

  void getData() async {
    try {
      List<double> dataCrypto = [];
      List<String> cryptoValueTmp = [];
      for (int i = 0; i < cryptoList.length; i++) {
        dataCrypto.insert(
            i, await CoinData().getCoinData(cryptoList[i], selectedCurrency));
      }
      setState(() {
        for (int i = 0; i < cryptoList.length; i++) {
          cryptoValueTmp.add(dataCrypto[i].toStringAsFixed(0));
        }
        cryptoValue = cryptoValueTmp;
      });
    } catch (e) {
      rethrow;
    }
  }

  Column makeButtons() {
    List<CryptoButton> cryptoButtons = [];
    for (String crypto in cryptoList) {
      cryptoButtons.add(
        CryptoButton(
          selectedCurrency: selectedCurrency,
          label: crypto,
          cryptoValue: cryptoValue,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoButtons,
    );
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < cryptoList.length; i++) {
      cryptoValue.add('?');
    }
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: bgColor,
        centerTitle: true,
        elevation: 5,
        title: const Text(
          'CRYPTO TRACKER',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 23.0,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          makeButtons(),
          const SizedBox(
            height: 60,
          ),
          CryptoMenu(
            coinMenu: Platform.isIOS
                ? Expanded(child: iOSPicker())
                : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

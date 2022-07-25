import 'package:flutter/material.dart';
import 'coin_data_basic.dart';

const buttonColor = Color(0xFF8ABDAD);
const bgColor = Color(0xFF1F2F16);

class CryptoButton extends StatelessWidget {
  const CryptoButton(
      {Key? key,
      required this.cryptoValue,
      required this.selectedCurrency,
      required this.label})
      : super(key: key);

  final List<String> cryptoValue;
  final String selectedCurrency;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: buttonColor,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 28.0),
          child: Center(
            child: Text(
              '1 $label = ${cryptoValue[cryptoList.indexOf(label)]} $selectedCurrency',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                color: bgColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CryptoMenu extends StatelessWidget {
  const CryptoMenu({Key? key, required this.coinMenu}) : super(key: key);

  final Widget coinMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 20, 18, 18),
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: bgColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(
                Icons.currency_exchange,
                color: bgColor,
                size: 50,
              ),
              coinMenu,
            ],
          ),
        ),
      ),
    );
  }
}

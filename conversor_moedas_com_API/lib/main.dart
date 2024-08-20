import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyConverterHome(),
    );
  }
}

class CurrencyConverterHome extends StatefulWidget {
  @override
  _CurrencyConverterHomeState createState() => _CurrencyConverterHomeState();
}

class _CurrencyConverterHomeState extends State<CurrencyConverterHome> {
  // Variáveis para armazenar as seleções e o valor
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  final TextEditingController _inputValueController = TextEditingController();
  double? _convertedValue;

  // Lista de moedas (adicione mais conforme necessário)
  final List<String> _currencies = ['USD', 'EUR', 'BRL', 'JPY'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _inputValueController,
              decoration: InputDecoration(
                labelText: 'Enter amount',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButton<String>(
                    value: _fromCurrency,
                    onChanged: (newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    },
                    items: _currencies.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Icon(Icons.arrow_forward),
                Expanded(
                  child: DropdownButton<String>(
                    value: _toCurrency,
                    onChanged: (newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    },
                    items: _currencies.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _convertCurrency();
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              _convertedValue != null
              ? 'Converted Value: $_convertedValue $_toCurrency'
            : 'Converted value will be shown here',
            style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<double> fetchExchangeRate(String fromCurrency, String toCurrency) async {
    final response = await http.get(
      Uri.parse('https://api.exchangerate-api.com/v4/latest/$fromCurrency'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['rates'][toCurrency];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  void _convertCurrency() async {
    if (_inputValueController.text.isNotEmpty) {
      // Converte o valor de entrada para double
      double inputValue = double.tryParse(_inputValueController.text) ?? 0.0;


      // Obtém a taxa de conversão
      double rate = await fetchExchangeRate(_fromCurrency, _toCurrency);



      setState(() {
        _convertedValue = inputValue * rate;
      });
    }
  }

}




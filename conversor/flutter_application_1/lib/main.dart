import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumberInputPage(),
    );
  }
}

class NumberInputPage extends StatefulWidget {
  @override
  _NumberInputPageState createState() => _NumberInputPageState();
}

class _NumberInputPageState extends State<NumberInputPage> {
  final TextEditingController _controller = TextEditingController();
  double? _savedNumber;
  int? vari;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Moeda'),
      ),
      
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = null;
                  vari = 1;
                });
              },
              child: Text('outras moedas pra real'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = null;
                  vari=2;
                });
              },
              child: Text('real pra outras moedas'),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Digite um valor'),
            ),
            SizedBox(height: 20),
            if(vari==1) ...[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = double.tryParse(_controller.text);
                  _savedNumber = (_savedNumber!*5);
                });
              },
              child: Text('Converter do Dolar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = double.tryParse(_controller.text);
                  _savedNumber = (_savedNumber!*6);
                });
              },
              child: Text('Converter do Euro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = double.tryParse(_controller.text);
                  _savedNumber = (_savedNumber!/1402);
                });
              },
              child: Text('Converter do Guarani'),
            ),
            if (_savedNumber != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Valor em reais: RS $_savedNumber'),
              ),
            ],
            if(vari==2) ...[
              SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = double.tryParse(_controller.text);
                  _savedNumber = (_savedNumber!/5);
                });
              },
              child: Text('Converter pro Dolar'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = double.tryParse(_controller.text);
                  _savedNumber = (_savedNumber!/6);
                });
              },
              child: Text('Converter pro Euro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _savedNumber = double.tryParse(_controller.text);
                  _savedNumber = (_savedNumber!*1402);
                });
              },
              child: Text('Converter pro Guarani'),
            ),
            if (_savedNumber != null)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('Valor convertido: R $_savedNumber'),
              ),
            ],
            
          ],
        ),
      ),
    );
  }
}

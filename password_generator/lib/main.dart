import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const PasswordGeneratorApp());
}

class PasswordGeneratorAppState extends State<PasswordGeneratorApp> {
  bool maiuscula = true;
  bool minuscula = true;
  bool caracterespecial = true;
  bool numeros = true;
  double range = 6;
  String pass = '';
  String forcaSenha = '';

  void passwordGeneratorState() {
  setState(() {
    pass = passwordGenerator();
    forcaSenha = testeForcaSenha(pass);
    print("Força da senha: $forcaSenha");
  });
}


  String passwordGenerator() {
    List<String> charList = <String>[
      maiuscula ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '',
      minuscula ? 'abcdefghijklmnopqrstuvwxyz' : '',
      numeros ? '0123456789' : '',
      caracterespecial ? '!@#\$%&*-=+,.<>;:/?' : ''
    ];

    final String chars = charList.join('');
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        range.round(), (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  Widget sizedBoxImg() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Image.network(
          "https://cdn.pixabay.com/photo/2013/04/01/09/02/read-only-98443_1280.png"),
    );
  }

  Widget TextoMaior() {
    return const Text(
      'Gerador automático de senha',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }

  Widget TextoMenor() {
    return const Text(
      'Aqui você escolhe como deseja gerar sua senha',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  Widget opcoes() {
    return Row(children: [
      Checkbox(
          value: maiuscula,
          onChanged: (bool? value) {
            setState(() {
              maiuscula = value!;
            });
          }),
      const Text('[A-Z]'),
      Checkbox(
          value: minuscula,
          onChanged: (bool? value) {
            setState(() {
              minuscula = value!;
            });
          }),
      const Text('[a-z]'),
      Checkbox(
          value: numeros,
          onChanged: (bool? value) {
            setState(() {
              numeros = value!;
            });
          }),
      const Text('[0-9]'),
      Checkbox(
          value: caracterespecial,
          onChanged: (bool? value) {
            setState(() {
              caracterespecial = value!;
            });
          }),
      const Text('[@#!]'),
    ]);
  }

  Widget botao() {
    return Container(
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        onPressed: passwordGeneratorState,
        child: const Text('Gerar senha'),
      ),
    );
  }

  Widget sizedBox() {
    return const SizedBox(
      height: 30,
    );
  }

  Widget slider() {
    return Slider(
      value: range,
      max: 50,
      divisions: 50,
      label: range.round().toString(),
      onChanged: (double newRange) {
        setState(() {
          range = newRange;
        });
      },
    );
  }

  Widget resultado() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width * .70,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            pass,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ));
  }

  Widget resultadoForcaSenha() {
    return SizedBox(
      height: 50,
      width: 350,
      child: Center(
        child: Text(
          'Força da senha: $forcaSenha',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de Senha'),
        ),
        body: Column(
          children: [
            sizedBoxImg(),
            TextoMaior(),
            TextoMenor(),
            sizedBox(),
            opcoes(),
            sizedBox(),
            slider(),
            botao(),
            sizedBox(),
            resultado(),
            resultadoForcaSenha(),
          ],
        ),
      ),
    );
  }
}

class PasswordGeneratorApp extends StatefulWidget {
  const PasswordGeneratorApp({super.key});

  @override
  PasswordGeneratorAppState createState() {
    return PasswordGeneratorAppState();
  }
}

String testeForcaSenha(String senha) {
  int forca = 0;

  if (senha.length >= 8) forca++;
  if (RegExp(r'[A-Z]').hasMatch(senha)) forca++;
  if (RegExp(r'[a-z]').hasMatch(senha)) forca++;
  if (RegExp(r'[0-9]').hasMatch(senha)) forca++;
  if (RegExp(r'[!@#\$%&*-=+,.<>;:/?]').hasMatch(senha)) forca++;

  if (forca <= 2) return 'Fraca';
  if (forca == 3 || forca == 4) return 'Média';
  return 'Forte';
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:math';

final TextEditingController _numeroPalitos = TextEditingController();
final TextEditingController _numeroMaxPalitos = TextEditingController();
final TextEditingController _numeroRetira = TextEditingController();
int numeroRetira = int.parse(_numeroRetira.text.trim());
int numeroMaxPalitos = int.parse(_numeroMaxPalitos.text.trim());
int numeroPalitos = int.parse(_numeroPalitos.text.trim());
int lastPieces = numeroPalitos % (numeroMaxPalitos + 1);
int piecesEx = 0;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void jogador() {
    setState(() {
      numeroRetira = int.parse(_numeroRetira.text);
      numeroPalitos = numeroPalitos - numeroRetira;
      Navigator.of(context).pop();
    });
  }

  void maquina() {
    setState(() {
      if (lastPieces == 0 || lastPieces == 1) {
      piecesEx = max(1, numeroMaxPalitos);
      numeroPalitos = numeroPalitos - piecesEx;
    }
    });
  }

  void modal() {
    String hintText = "Limite é de $numeroMaxPalitos";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QUE COMECE O DESAFIO'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Numero de Palitos: $numeroPalitos'),
              Text("Palitos tirados pelo computador: $piecesEx"),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Quanto irá retirar',
                        hintText: hintText, // Usando a variável hintText
                      ),
                      controller: _numeroRetira,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      jogador();
                      maquina();

                    },
                    child: const Text("Retirar"),
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text("Bem Vindo ao Jogo Nim! Vamos jogar?"),
          Row(
            children: [
              SizedBox(
                width: 200.00,
                child: TextField(
                  keyboardType: TextInputType
                      .number, // Define o tipo de teclado para números
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Digite números',
                    hintText: '0',
                  ),
                  controller: _numeroPalitos,
                ),
              ),
              const SizedBox(width: 25.0),
              const SizedBox(
                width: 300,
                child: Text("Numero Maximo de Palitos"),
              ),
            ],
          ),
          Row(children: [
            SizedBox(
              width: 200.00,
              child: TextField(
                keyboardType: TextInputType
                    .number, // Define o tipo de teclado para números
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Digite números',
                  hintText: '0',
                ),
                controller: _numeroMaxPalitos,
              ),
            ),
            const SizedBox(width: 25.0),
            const SizedBox(
              width: 300,
              child: Text("Palitos Maximos a Serem Retirados"),
            ),
          ]),
          Row(children: [
            TextButton(
                onPressed: () {
                  String numeroPalitosStr = _numeroPalitos.text.trim();

                  String numeroMaxPalitosStr = _numeroMaxPalitos.text.trim();

                  if (numeroPalitosStr.isEmpty || numeroMaxPalitosStr.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Preencha os campos antes de iniciar o jogo.'),
                      ),
                    );
                    return;
                  }

                  modal();
                },
                child: Text("Iniciar Jogo"),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                )),
            const SizedBox(width: 25.0),
            TextButton(
                onPressed: () async {
                  Uri teste = Uri.parse(
                      'https://jogoseeducacao.ime.ufg.br/p/2135-nim'); // Substitua pelo URL desejado
                  if (await canLaunchUrl(teste)) {
                    await launchUrl(teste);
                  } else {
                    throw 'Não foi possível abrir o link: $teste';
                  }
                },
                child: Text("Como jogar"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.black))
          ]),
        ],
      ),
    );
  }
}

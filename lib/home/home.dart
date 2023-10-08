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
String winner = "";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void jogador() {
    setState(() {
      numeroRetira = int.parse(_numeroRetira.text);
      if (numeroRetira > numeroMaxPalitos ||
          numeroRetira == 0 ||
          numeroPalitos == 0) {
        return;
      }
      numeroPalitos = numeroPalitos - numeroRetira;
      Navigator.of(context).pop();
      if (numeroPalitos <= 0) {
        winner = "Computador";
        if (numeroPalitos < 0){
        numeroPalitos = 0;
        }
      }
    });
  }

  void maquina() {
  setState(() {
    if (numeroPalitos % (numeroMaxPalitos + 1) == 0) {
      // Se o número de palitos é um múltiplo de (numeroMaxPalitos + 1),
      // o robô retira uma quantidade aleatória de palitos, mas nunca zero.
      piecesEx = Random().nextInt(numeroMaxPalitos) + 1;
    } else {
      // Se não é um múltiplo, o robô retira uma quantidade para torná-lo um múltiplo.
      int remainder = numeroPalitos % (numeroMaxPalitos + 1);
      piecesEx = numeroMaxPalitos - remainder;
    }

    // Atualiza o número de palitos restantes.
    numeroPalitos -= piecesEx;

    // Garante que o robô nunca tire zero palitos.
    if (piecesEx == 0) {
      piecesEx = 1;
      numeroPalitos -= 1;
    }

    if (numeroPalitos - numeroMaxPalitos == 0){
      piecesEx = numeroMaxPalitos - 1;
    }

    if (numeroPalitos <= 0) {
      winner = "Usuário";  // Atualizado para "Usuário" pois o robô sempre ganha
      numeroPalitos = 0;
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
                      if (numeroRetira > numeroMaxPalitos ||
                          numeroRetira == 0 ||
                          numeroPalitos == 0) {
                        return;
                      }
                      maquina();
                      modal();
                    },
                    child: const Text("Retirar"),
                  ),
                ],
              ),
              Text("E o vencedor é o: $winner")
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
          const SizedBox(height: 25.0),
          const Row(
            children: [
              Text("Bem Vindo ao Jogo Nim! Vamos jogar?"),
            ],
          ),
          const SizedBox(height: 5.0),
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
                width: 130,
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
              width: 130,
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
                      const SnackBar(
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

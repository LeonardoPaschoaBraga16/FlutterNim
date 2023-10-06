import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _numeroPalitos = TextEditingController();
  final TextEditingController _numeroMaxPalitos = TextEditingController();
  final valor = 0;

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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "0.0",
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "0.0",
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
            TextButton(onPressed: () {}, child:  Text("Iniciar Jogo"), style: TextButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.black,)),
            const SizedBox(width: 25.0),
            TextButton(onPressed: () async {
              Uri teste = Uri.parse('https://jogoseeducacao.ime.ufg.br/p/2135-nim');  // Substitua pelo URL desejado
              if (await canLaunchUrl(teste)) {
                await launchUrl(teste);
              } else {
                throw 'Não foi possível abrir o link: $teste';
              }
            }, child: Text("Como jogar"), style: TextButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.black))
          ]),
          Text("$valor")
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _numeroPalitos = TextEditingController();
  final TextEditingController _numeroMaxPalitos = TextEditingController();

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
            TextButton(onPressed: () {}, child: Text("Como jogar"), style: TextButton.styleFrom(
              backgroundColor: Colors.blue, foregroundColor: Colors.black))
          ]),
        ],
      ),
    );
  }
}

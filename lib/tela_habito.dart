import 'package:flutter/material.dart';
import 'package:tela_habitos/main.dart';

void priorizar(Habito h, List<Habito> list){
  list.remove(h);
  list.insert(0, h);
}

class TelaHabito extends StatelessWidget {
  const TelaHabito({super.key, required this.habito, required this.pos, required this.list});
  final Habito habito;
  final int pos;
  final List<Habito> list;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(habito.nome)),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/cabecalho.jpg', height: 100, width: double.infinity, fit: BoxFit.cover),
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.mood, 
                  size: 50, 
                  color: Colors.yellow,
                ),
              ),
              const Positioned(
                top: 0,
                left: 0,
                child: Icon(
                  Icons.circle, 
                  size: 100, 
                  color: Colors.white,
                ),
              ),
              Positioned(
                top: 25,
                left: 25,
                child: Icon(
                  habito.icone, 
                  size: 50, 
                  color: Colors.black,
                ),
              ),
              Positioned(
                top: 20,
                left: 100,
                child: Text(
                  "${habito.nome} [$pos]", 
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                )
              ),
              Positioned(
                top: 50,
                left: 100,
                child: Text(
                  habito.meta, 
                  style: TextStyle(
                    color: Colors.white
                  )
                )
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity, 
            child: Card(
              margin: const EdgeInsets.all(16),

              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sobre esse hábito', 
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold
                      )
                    ),
                    SizedBox(height: 8),
                    Text(habito.descricao),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        priorizar(habito, list);
      }
    )
  );
}
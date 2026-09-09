import 'package:flutter/material.dart';

class TelaHabito extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('< Beber água')),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/cabecalho.jpg', height: 100, width: 800, fit: BoxFit.cover),
              const Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.star, 
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
              const Positioned(
                top: 30,
                left: 25,
                child: Text('H2O', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              const Positioned(
                top: 20,
                left: 100,
                child: Text(
                  'Beber água', 
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  )
                )
              ),
              const Positioned(
                top: 50,
                left: 110,
                child: Text(
                  'Meta: 8 copos por dia', 
                  style: TextStyle(
                    color: Colors.white
                  )
                )
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(
                child: Text(
                  '12 dias seguidos', 
                  textAlign: TextAlign.center
                )
              ),
              Expanded(
                child: Text(
                  '5/8 hoje', 
                  textAlign: TextAlign.center
                  )
                ),
              Expanded(
                child: Text(
                  '62% no mês', 
                  textAlign: TextAlign.center
                )
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Sobre esse hábito', 
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: 8),
                  Text('Beber agua ao longo do dia ajuda a manter a concentração e o bem-estar.'),
                  SizedBox(height: 8),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    )
  );
}

/*
Scaffold
└── SingleChildScrollView
    └── Column
        ├── Stack              imagem do cabeçalho com ícone sobreposto
        ├── SizedBox           espaço
        ├── Row                três indicadores, cada um em Expanded
        ├── SizedBox
        └── Card               bloco de texto
*/
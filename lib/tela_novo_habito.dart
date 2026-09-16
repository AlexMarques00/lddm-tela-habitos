import 'package:flutter/material.dart';

class TelaNovoHabito extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Adicionar Novo Hábito')),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
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
            ],
          ),
        ],
      ),
    ),
  );
}

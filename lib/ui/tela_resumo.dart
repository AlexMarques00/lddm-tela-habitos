import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habitos_store.dart';

class TelaResumo extends StatelessWidget {
  const TelaResumo({super.key});

  @override
  Widget build(BuildContext context) {
    final total = context.watch<HabitosStore>().habitos.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Total de Hábitos Ativos:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 12),
            Text(
              '$total',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
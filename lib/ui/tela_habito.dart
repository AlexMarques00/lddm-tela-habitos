import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habito.dart';
import '../dominio/habitos_store.dart';

class TelaHabito extends StatelessWidget {
  const TelaHabito({
    super.key,
    required this.habito,
    required this.pos,
  });

  final Habito habito;
  final int pos;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(habito.nome)),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/cabecalho.jpg',
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 110,
                  color: Colors.deepPurple,
                ),
              ),
              Positioned(
                top: 0,
                right: 12,
                child: Text(
                  '$pos',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
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
                left: 110,
                child: Text(
                  habito.nome,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 110,
                child: Text(
                  habito.meta,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
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
                    const Text(
                      'Sobre esse hábito',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(habito.descricao),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.move_up, size: 20),
                        label: const Text('Mover para cima'),
                        onPressed: () {
                          context.read<HabitosStore>().priorizar(habito);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.move_down, size: 20),
                        label: const Text('Mover para baixo'),
                        onPressed: () {
                          context.read<HabitosStore>().despriorizar(habito);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.delete, size: 20),
                    label: const Text('Deletar'),
                    onPressed: () async {
                      final confirmou = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirmar exclusão'),
                          content: Text('Tem certeza que deseja apagar "${habito.nome}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text(
                                'Deletar',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirmou == true && context.mounted) {
                        final store = context.read<HabitosStore>();
                        store.remover(habito);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:tela_habitos/main.dart';

void priorizar(Habito h, List<Habito> list) {
  list.remove(h);
  list.insert(0, h);
}

void deletar(Habito h, List<Habito> list) {
  list.remove(h);
}

class TelaHabito extends StatelessWidget {
  const TelaHabito({
    super.key,
    required this.habito,
    required this.pos,
    required this.list,
  });

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
                  Image.asset(
                    'assets/cabecalho.jpg',
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
                child: Row(
                  children: [
                    // Botão Priorizar
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.priority_high, size: 20),
                        label: const Text(
                          'Priorizar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          priorizar(habito, list);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${habito.nome} foi priorizado!',
                              ),
                            ),
                          );
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                    const SizedBox(width: 12), // Espaçamento entre os botões
                    // Botão Deletar (Cor Negativa / Destrutiva)
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: const Icon(Icons.delete, size: 20),
                        label: const Text(
                          'Deletar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          // Exibe o diálogo de confirmação
                          final confirmou = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirmar exclusão'),
                              content: Text('Tem certeza que deseja apagar o hábito "${habito.nome}"?'),
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

                          if (confirmou == true) {
                            deletar(habito, list);
                            
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${habito.nome} foi removido!',
                                  ),
                                ),
                              );
                              Navigator.pop(context, true);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
}
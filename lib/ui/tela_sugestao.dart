import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dominio/habito.dart';
import '../dominio/habitos_store.dart';
import '../dominio/sugestoes_store.dart';

class TelaSugestoes extends StatelessWidget {
  const TelaSugestoes({super.key});

  @override
  Widget build(BuildContext context) {
    final loja = context.watch<SugestoesStore>();

    switch (loja.estado) {
      case Estado.carregando:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );

      case Estado.erro:
        return Scaffold(
          appBar: AppBar(title: const Text('Sugestões')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(loja.mensagemErro ?? 'Ocorreu um erro.'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => loja.carregar(),
                  child: const Text('Tentar de novo'),
                ),
              ],
            ),
          ),
        );

      case Estado.pronto:
        if (loja.sugestoes.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Sugestões')),
            body: const Center(
              child: Text('Nenhuma sugestão encontrada.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Sugestões de Hábitos')),
          body: ListView.builder(
            itemCount: loja.sugestoes.length,
            itemBuilder: (context, index) {
              final sugestao = loja.sugestoes[index];
              return ListTile(
                leading: const Icon(Icons.lightbulb_outline),
                title: Text(sugestao.titulo),
                subtitle: Text(sugestao.feito ? 'Concluído na API' : 'Pendente na API'),
                trailing: const Icon(Icons.add),
                onTap: () {
                  context.read<HabitosStore>().adicionar(
                        Habito(
                          nome: sugestao.titulo,
                          meta: 'Meta a definir',
                          icone: Icons.star,
                          descricao: 'Hábito importado da API pública.',
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hábito "${sugestao.titulo}" gravado no banco local!'),
                    ),
                  );
                },
              );
            },
          )
        );
    }
  }
}
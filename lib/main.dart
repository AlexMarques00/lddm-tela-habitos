import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dados/habitos_repositorio.dart';
import 'dominio/habitos_store.dart';
import 'ui/tela_habito.dart';
import 'ui/tela_novo_habito.dart';

void main() {
  final repo = HabitosRepositorio();

  runApp(
    ChangeNotifierProvider(
      create: (_) => HabitosStore(repo)..carregar(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TelaPrincipal(),
      ),
    ),
  );
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _aba = 0;

  @override
  Widget build(BuildContext context) {
    final telas = [
      const TelaListaHabitos(),
      const TelaResumo(),
      const Center(child: Text('Tela de Perfil')),
    ];

    return Scaffold(
      body: telas[_aba],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _aba,
        onDestinationSelected: (i) => setState(() => _aba = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: 'Hábitos'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Resumo'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class TelaListaHabitos extends StatelessWidget {
  const TelaListaHabitos({super.key});

  @override
  Widget build(BuildContext context) {
    final habitos = context.watch<HabitosStore>().habitos;

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Hábitos')),
      body: habitos.isEmpty
          ? const Center(child: Text('Nenhum hábito cadastrado'))
          : ListView.builder(
              itemCount: habitos.length,
              itemBuilder: (context, index) {
                final h = habitos[index];
                return ListTile(
                  leading: Icon(h.icone),
                  title: Text(h.nome),
                  subtitle: Text(h.meta),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TelaHabito(habito: h, pos: index),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TelaNovoHabito()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
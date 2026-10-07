import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dados/habitos_repositorio.dart';
import 'dados/preferencias_repositorio.dart';
import 'dominio/habitos_store.dart';
import 'ui/tela_habito.dart';
import 'ui/tela_novo_habito.dart';
import 'ui/tela_resumo.dart';

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
  final _prefsRepo = PreferenciasRepositorio();
  int _aba = 0;

  @override
  void initState() {
    super.initState();
    _carregarAba();
  }

  Future<void> _carregarAba() async {
    final abaSalva = await _prefsRepo.lerUltimaAba();
    setState(() {
      _aba = abaSalva;
    });
  }

  void _selecionarAba(int i) {
    setState(() => _aba = i);
    _prefsRepo.salvarUltimaAba(i);
  }

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
        onDestinationSelected: _selecionarAba,
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
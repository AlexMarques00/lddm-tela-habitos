import 'package:flutter/material.dart';
import 'tela_habito.dart';
import 'tela_novo_habito.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(futuro: carregarHabitos()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.futuro});

  final Future<List<Habito>> futuro;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Meus Hábitos')),
    body: FutureBuilder<List<Habito>>(
      future: futuro,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Não foi possível carregar'));
        }
        final habitos = snapshot.data ?? [];
        if (habitos.isEmpty) {
          return const Center(child: Text('Nenhum hábito ainda'));
        }
        return ListView(
          children: [
            for (final h in habitos)
              ListTile(
                leading: Icon(h.icone),
                title: Text(h.nome),
                subtitle: Text(h.meta),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaHabito(habito: h),
                    ),
                  );
                },
              ),
          ],
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () async {
        final novo = await Navigator.push<Habito>(
          context,
          MaterialPageRoute(builder: (_) => TelaNovoHabito()),
        );
        // if (!mounted) return;                    // a tela pode ter saído
        // if (novo != null) {
        //   setState(() => _habitos.add(novo));
        // }
      },
      child: const Icon(Icons.add),
    ),
  );
}

class Habito{
  final String nome;
  final String meta;
  final IconData icone;
  final String sigla;
  final String descricao;

  const Habito(this.nome, this.meta, this.icone, this.sigla, this.descricao);
}

Future<List<Habito>> carregarHabitos() async {
  await Future.delayed(const Duration(seconds: 0));

  // throw Exception('servidor fora do ar');
  return [
    Habito('Beber água', 'Meta: 8 copos por dia', Icons.local_drink, 'H2O', 'Beber água ao longo do dia ajuda a manter a concentração e o bem-estar.'),
    Habito('Ler', 'Meta: 20 páginas por dia', Icons.menu_book, 'BOOK', 'Ler por pelo menos 30 minutos por dia melhora a concentração e o vocabulário.'),
    Habito('Caminhar', 'Meta: 30 minutos por dia', Icons.directions_walk, 'WALK', 'Caminhar diariamente melhora a saúde física e mental.'),
    Habito('Dormir cedo', 'Meta: antes das 23h', Icons.bedtime, 'SLEEP', 'Dormir cedo ajuda a manter um ciclo de sono saudável.'),
  ];
}
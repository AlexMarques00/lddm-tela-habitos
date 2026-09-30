import 'package:flutter/material.dart';
import 'tela_habito.dart';
import 'tela_novo_habito.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Habito>> _futuroHabitos;
  List<Habito> _listaHabitos = [];

  @override
  void initState() {
    super.initState();
    _futuroHabitos = carregarHabitos().then((habitos) {
      _listaHabitos = habitos;
      return _listaHabitos;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Meus Hábitos')),
        body: FutureBuilder<List<Habito>>(
          future: _futuroHabitos,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Não foi possível carregar'));
            }
            if (_listaHabitos.isEmpty) {
              return const Center(child: Text('Nenhum hábito ainda'));
            }
            return ListView.builder(
              itemCount: _listaHabitos.length,
              itemBuilder: (context, index) {
                final h = _listaHabitos[index];
                return ListTile(
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
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Aguarda o retorno do novo hábito da TelaNovoHabito
            final novo = await Navigator.push<Habito>(
              context,
              MaterialPageRoute(builder: (_) => TelaNovoHabito()),
            );
            
            if (!mounted) return; // Garante que a tela ainda está ativa

            // Se o usuário preencheu e salvou um hábito novo, adiciona à lista
            if (novo != null) {
              setState(() {
                _listaHabitos.add(novo);
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      );
}

class Habito {
  final String nome;
  final String meta;
  final IconData icone;
  final String sigla;
  final String descricao;

  const Habito(this.nome, this.meta, this.icone, this.sigla, this.descricao);
}

Future<List<Habito>> carregarHabitos() async {
  await Future.delayed(const Duration(milliseconds: 300));

  return [
    const Habito('Beber água', 'Meta: 8 copos por dia', Icons.local_drink, 'H2O', 'Beber água ao longo do dia ajuda a manter a concentração e o bem-estar.'),
    const Habito('Ler', 'Meta: 20 páginas por dia', Icons.menu_book, 'BOOK', 'Ler por pelo menos 30 minutos por dia melhora a concentração e o vocabulário.'),
    const Habito('Caminhar', 'Meta: 30 minutos por dia', Icons.directions_walk, 'WALK', 'Caminhar diariamente melhora a saúde física e mental.'),
    const Habito('Dormir cedo', 'Meta: antes das 23h', Icons.bedtime, 'SLEEP', 'Dormir cedo ajuda a manter um ciclo de sono saudável.'),
  ];
}
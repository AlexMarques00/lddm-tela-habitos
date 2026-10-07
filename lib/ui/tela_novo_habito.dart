import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dominio/habito.dart';
import '../dominio/habitos_store.dart';

class TelaNovoHabito extends StatefulWidget {
  const TelaNovoHabito({super.key});

  @override
  State<TelaNovoHabito> createState() => _TelaNovoHabitoState();
}

class _TelaNovoHabitoState extends State<TelaNovoHabito> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomeController;
  late final TextEditingController _metaController;
  late final TextEditingController _descricaoController;

  IconData _iconeSelecionado = Icons.star;

  final List<IconData> _iconesDisponiveis = const [
    Icons.star,
    Icons.local_drink,
    Icons.menu_book,
    Icons.bedtime,
    Icons.fitness_center,
    Icons.restaurant,
    Icons.work,
    Icons.code,
    Icons.music_note,
    Icons.sports_soccer,
  ];

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _metaController = TextEditingController();
    _descricaoController = TextEditingController();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _metaController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _salvarHabito() {
    if (_formKey.currentState!.validate()) {
      final novoHabito = Habito(
        nome: _nomeController.text,
        meta: "Meta: ${_metaController.text}",
        icone: _iconeSelecionado,
        descricao: _descricaoController.text,
      );

      context.read<HabitosStore>().adicionar(novoHabito);
      Navigator.pop(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Novo Hábito')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Hábito',
                  hintText: 'Ex: Beber água, Ler...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.star_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira o nome do hábito.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _metaController,
                decoration: const InputDecoration(
                  labelText: 'Meta do Hábito',
                  hintText: 'Ex: 8 copos por dia',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, insira uma meta.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descrição ou Motivação (Opcional)',
                  hintText: 'Ex: Ajuda a manter o foco e a saúde...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.notes),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Escolha um Ícone:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 70,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: _iconesDisponiveis.length,
                itemBuilder: (context, index) {
                  final icone = _iconesDisponiveis[index];
                  final estaSelecionado = icone == _iconeSelecionado;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _iconeSelecionado = icone;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: estaSelecionado
                            ? Colors.deepPurple.withOpacity(0.2)
                            : Colors.grey[200],
                        border: Border.all(
                          color: estaSelecionado
                              ? Colors.deepPurple
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icone,
                        color: estaSelecionado
                            ? Colors.deepPurple
                            : Colors.black54,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _salvarHabito,
                icon: const Icon(Icons.check),
                label: const Text(
                  'Salvar Hábito',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
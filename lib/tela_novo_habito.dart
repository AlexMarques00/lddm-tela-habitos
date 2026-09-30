import 'package:flutter/material.dart';
import 'package:tela_habitos/main.dart';

class TelaNovoHabito extends StatefulWidget {
  const TelaNovoHabito({Key? key}) : super(key: key);

  @override
  State<TelaNovoHabito> createState() => _TelaNovoHabitoState();
}

class _TelaNovoHabitoState extends State<TelaNovoHabito> {
  // Chave para validar o formulário
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para os campos de texto
  final _nomeController = TextEditingController();
  final _metaController = TextEditingController();
  final _descricaoController = TextEditingController();
  
  // Ícone selecionado por padrão (começa com a estrela)
  IconData _iconeSelecionado = Icons.star;

  // Lista de ícones disponíveis para o usuário escolher
  final List<IconData> _iconesDisponiveis = [
    Icons.star,
    Icons.local_drink,
    Icons.menu_book,
    Icons.directions_walk,
    Icons.bedtime,
    Icons.fitness_center,
    Icons.self_improvement,
    Icons.restaurant,
    Icons.work,
    Icons.code,
    Icons.music_note,
    Icons.sports_soccer,
  ];

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
        _nomeController.text,
        "Meta: ${_metaController.text}",
        _iconeSelecionado,
        _descricaoController.text,
      );

      // Retorna o objeto para a tela anterior (MyApp)
      Navigator.pop(context, novoHabito); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Hábito'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Campo para o Nome do Hábito
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

              // Campo para a Meta
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

              // Campo para Descrição / Motivação
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

              // Seletor de Ícone (Grid Responsiva)
              const Text(
                'Escolha um Ícone:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              
              GridView.builder(
                shrinkWrap: true, // Faz a grid ocupar apenas o espaço necessário
                physics: const NeverScrollableScrollPhysics(), // Desativa o scroll próprio da grid (usa o do SingleChildScrollView)
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 70, // Largura máxima de cada item; criará mais ou menos colunas dependendo da tela
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1, // Mantém os quadradinhos proporcionais (1:1)
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
                        color: estaSelecionado ? Colors.deepPurple.withOpacity(0.2) : Colors.grey[200],
                        border: Border.all(
                          color: estaSelecionado ? Colors.deepPurple : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icone,
                        color: estaSelecionado ? Colors.deepPurple : Colors.black54,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Botão de Salvar
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
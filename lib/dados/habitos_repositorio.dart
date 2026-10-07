import '../dominio/habito.dart';
import 'package:flutter/material.dart';

class HabitosRepositorio {
  final List<Habito> _memoria = [
    const Habito(
      'Beber água',
      'Meta: 8 copos por dia',
      Icons.local_drink,
      'Beber água ao longo do dia ajuda a manter a concentração e o bem-estar.',
    ),
    const Habito(
      'Ler',
      'Meta: 20 páginas por dia',
      Icons.menu_book,
      'Ler por pelo menos 30 minutos por dia melhora a concentração e o vocabulário.',
    ),
    const Habito(
      'Caminhar',
      'Meta: 30 minutos por dia',
      Icons.directions_walk,
      'Caminhar diariamente melhora a saúde física e mental.',
    ),
    const Habito(
      'Dormir cedo',
      'Meta: antes das 23h',
      Icons.bedtime,
      'Dormir cedo ajuda a manter um ciclo de sono saudável.',
    ),
  ];

  Future<List<Habito>> carregar() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.of(_memoria);
  }

  Future<void> salvar(Habito h) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _memoria.add(h);
  }

  Future<void> priorizar(Habito h) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _memoria.indexOf(h);
    if (index != -1) {
      final item = _memoria.removeAt(index);
      _memoria.insert(0, item);
    }
  }

  Future<void> despriorizar(Habito h) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final index = _memoria.indexOf(h);
    if (index != -1) {
      final item = _memoria.removeAt(index);
      _memoria.insert(_memoria.length, item);
    }
  }

  Future<void> remover(Habito h) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _memoria.remove(h);
  }
}
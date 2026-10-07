import 'package:flutter/widgets.dart';

class Habito {
  final int? id;
  final String nome;
  final String meta;
  final IconData icone;
  final String descricao;
  final double ordem;

  const Habito({
    this.id,
    required this.nome,
    required this.meta,
    required this.icone,
    required this.descricao,
    this.ordem = 0.0,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'nome': nome,
        'meta': meta,
        'icone_code': icone.codePoint,
        'descricao': descricao,
        'ordem': ordem,
      };

  factory Habito.fromMap(Map<String, Object?> m) => Habito(
        id: m['id'] as int?,
        nome: m['nome'] as String,
        meta: m['meta'] as String,
        icone: IconData(
          m['icone_code'] as int,
          fontFamily: 'MaterialIcons',
        ),
        descricao: m['descricao'] as String,
        ordem: (m['ordem'] as num?)?.toDouble() ?? 0.0,
      );
}
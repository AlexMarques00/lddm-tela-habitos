import 'package:flutter/widgets.dart'; // Apenas para ter o tipo IconData

class Habito {
  final String nome;
  final String meta;
  final IconData icone;
  final String descricao;

  const Habito(this.nome, this.meta, this.icone, this.descricao);
}
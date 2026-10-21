class Sugestao {
  const Sugestao({required this.titulo, required this.feito});

  final String titulo;
  final bool feito;

  factory Sugestao.fromMap(Map<String, Object?> m) => Sugestao(
        titulo: m['title'] as String? ?? '(sem título)',
        feito: m['completed'] as bool? ?? false,
      );
}
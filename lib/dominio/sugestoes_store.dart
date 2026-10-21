import 'package:flutter/foundation.dart';
import '../dados/sugestoes_api.dart';
import 'sugestao.dart';

enum Estado { carregando, pronto, erro }

class SugestoesStore extends ChangeNotifier {
  SugestoesStore(this._repo) {
    carregar();
  }

  final SugestoesApi _repo;

  List<Sugestao> _sugestoes = [];
  Estado estado = Estado.carregando;
  String? mensagemErro;

  List<Sugestao> get sugestoes => List.unmodifiable(_sugestoes);

  Future<void> carregar() async {
    estado = Estado.carregando;
    notifyListeners();

    try {
      _sugestoes = await _repo.carregar();
      estado = Estado.pronto;
    } catch (e) {
      estado = Estado.erro;
      mensagemErro = 'Não foi possível carregar as sugestões.';
    }

    notifyListeners();
  }
}
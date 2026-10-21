import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dominio/sugestao.dart';

class SugestoesApi {
  static const _base = 'https://jsonplaceholder.typicode.com';

  Future<List<Sugestao>> carregar() async {
    final url = Uri.parse('$_base/todos?_limit=10');
    final resposta = await http.get(url).timeout(const Duration(seconds: 10));

    if (resposta.statusCode != 200) {
      throw Exception('O servidor respondeu com status ${resposta.statusCode}');
    }

    final List<dynamic> bruto = jsonDecode(resposta.body);
    return bruto
        .map((m) => Sugestao.fromMap(m as Map<String, Object?>))
        .toList();
  }
}
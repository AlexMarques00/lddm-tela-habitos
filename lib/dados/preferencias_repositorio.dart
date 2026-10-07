import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasRepositorio {
  static const _chaveAba = 'ultima_aba_selecionada';

  Future<void> salvarUltimaAba(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_chaveAba, index);
  }

  Future<int> lerUltimaAba() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_chaveAba) ?? 0;
  }
}
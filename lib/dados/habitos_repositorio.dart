import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../dominio/habito.dart';

class HabitosRepositorio {
  Future<Database> _abrir() async => openDatabase(
        join(await getDatabasesPath(), 'habitos.db'),
        version: 1,
        onCreate: (db, _) => db.execute(
          'CREATE TABLE habitos('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'nome TEXT NOT NULL, '
          'meta TEXT NOT NULL, '
          'icone_code INTEGER NOT NULL, '
          'descricao TEXT NOT NULL, '
          'ordem INT NOT NULL DEFAULT 0)',
        ),
      );

  Future<List<Habito>> carregar() async {
    final db = await _abrir();
    final linhas = await db.query('habitos', orderBy: 'ordem ASC, id ASC');
    return linhas.map(Habito.fromMap).toList();
  }

  Future<void> salvar(Habito h) async {
    final db = await _abrir();
    
    final res = await db.rawQuery('SELECT MIN(ordem) as min_ordem FROM habitos');
    final minOrdem = (res.first['min_ordem'] as num?)?.toInt() ?? 0;

    final mapa = h.toMap();
    mapa['ordem'] = minOrdem - 1;

    await db.insert('habitos', mapa);
    await _normalizarSeNecessario(db);
  }

  Future<void> priorizar(Habito h) async {
    if (h.id == null) return;
    final db = await _abrir();

    final res = await db.rawQuery('SELECT MIN(ordem) as min_ordem FROM habitos');
    final minOrdem = (res.first['min_ordem'] as num?)?.toInt() ?? 0;

    await db.update(
      'habitos',
      {'ordem': minOrdem - 1},
      where: 'id = ?',
      whereArgs: [h.id],
    );

    await _normalizarSeNecessario(db);
  }

  Future<void> despriorizar(Habito h) async {
    if (h.id == null) return;
    final db = await _abrir();

    final res = await db.rawQuery('SELECT MAX(ordem) as max_ordem FROM habitos');
    final maxOrdem = (res.first['max_ordem'] as num?)?.toInt() ?? 0;

    await db.update(
      'habitos',
      {'ordem': maxOrdem + 1},
      where: 'id = ?',
      whereArgs: [h.id],
    );

    await _normalizarSeNecessario(db);
  }

  Future<void> remover(Habito h) async {
    if (h.id == null) return;
    final db = await _abrir();
    await db.delete('habitos', where: 'id = ?', whereArgs: [h.id]);
    await _normalizarSeNecessario(db);
  }

  Future<void> _normalizarSeNecessario(Database db) async {
    final habitos = await carregar();
    if (habitos.isEmpty) return;

    final menor = habitos.first.ordem;
    final maior = habitos.last.ordem;
    final quantidade = habitos.length;

    final amplitude = maior - menor;
    final limiteDiscrepancia = (quantidade * 2) + 10;

    if (amplitude > limiteDiscrepancia) {
      await db.transaction((txn) async {
        for (var i = 0; i < habitos.length; i++) {
          await txn.update(
            'habitos',
            {'ordem': i},
            where: 'id = ?',
            whereArgs: [habitos[i].id],
          );
        }
      });
    }
  }
}
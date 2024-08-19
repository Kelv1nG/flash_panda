import 'package:flash_cards/models/subject.dart';
import 'package:flash_cards/core/database.dart' as db_conn;

const tableName = 'subjects';

Future<void> addSubject(Subject subject) async {
  final db = await db_conn.open();
  await db.insert(
    tableName,
    subject.toMap(),
  );
}

Future<List<Subject>> listSubjects() async {
  final db = await db_conn.open();
  final List<Map<String, Object?>> subjectMaps = await db.query(tableName);

  return [
    for (final {
          'id': id as int,
          'name': String name as String,
        } in subjectMaps)
      Subject(id: id, name: name),
  ];
}

Future<void> updateSubject(Subject subject) async {
  final db = await db_conn.open();
  await db.update(
    tableName,
    subject.toMap(),
    where: 'id = ?',
    whereArgs: [subject.id],
  );
}

Future<void> deleteSubject(int id) async {
  final db = await db_conn.open();
  await db.delete(
    tableName,
    where: 'id = ?',
    whereArgs: [id],
  );
}

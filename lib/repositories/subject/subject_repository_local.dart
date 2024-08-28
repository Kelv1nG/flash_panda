import 'package:sqflite/sqflite.dart';
import 'subject_repository_interface.dart';
import 'models/subject.dart';
import 'package:flash_cards/core/database.dart' as db_conn;
import 'exceptions.dart';

const tableName = 'subjects';

class SubjectRepositoryLocal implements SubjectRepositoryInterface {
  SubjectRepositoryLocal() {
    _initDb();
  }

  late Database _db;
  Future<void>? _initDbFuture;

  Future<void> _initDb() async {
    if (_initDbFuture != null) return _initDbFuture;

    _initDbFuture = db_conn.open().then((database) {
      _db = database;
    });

    return _initDbFuture;
  }

  Future<Database> _getDb() async {
    await _initDb();
    return _db;
  }

  @override
  Future<Subject> addSubject(Subject subject) async {
    final db = await _getDb();
    final id = await db.insert(tableName, subject.toJson());
    return subject.copyWith(id: id);
  }

  @override
  Future<Subject> getSubject(int subjectId) async {
    final db = await _getDb();
    final result = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [subjectId],
    );
    if (!result.isNotEmpty) {
      throw SubjectNotFound();
    }

    return Subject.fromJson(result.first);
  }

  @override
  Future<List<Subject>> listSubjects() async {
    final db = await _getDb();
    final List<Map<String, Object?>> result = await db.query(tableName);

    return result.map((item) => Subject.fromJson(item)).toList();
  }

  @override
  Future<Subject> updateSubject(Subject subject) async {
    final db = await _getDb();
    final int affectedRowsCount = await db.update(
      tableName,
      subject.toJson(),
      where: 'id = ?',
      whereArgs: [subject.id],
    );
    if (affectedRowsCount == 0) {
      throw SubjectNotFound();
    }
    return subject;
  }

  @override
  Future<void> deleteSubject(int id) async {
    final db = await db_conn.open();
    final int affectedRowsCount = await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (affectedRowsCount == 0) {
      throw SubjectNotFound();
    }
  }
}

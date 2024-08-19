import "package:sqflite/sqflite.dart";
import "package:logging/logging.dart";

final log = Logger("database");

const dbUri = "flash_cards.db";

Future<Database> open() async {
  return openDatabase(
    dbUri,
  );
}

Future<Database> initializeDb() async {
  log.info("Initializing Database...");
  return openDatabase(
    dbUri,
    version: 1,
    onCreate: (Database db, int ver) async {
      await createTables(db);
    },
    onOpen: (Database db) async {
      //await dropAllTables(db);
      await createTables(db);
    },
  );
}

Future<void> createTables(Database db) async {
  log.info("Creating Tables...");
  await db.execute(
    'CREATE TABLE IF NOT EXISTS subjects(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)',
  );
  await db.execute(
    'CREATE TABLE IF NOT EXISTS test(test TEXT)',
  );
}

Future<void> dropAllTables(Database db) async {
  log.info("Dropping Tables...");
  final List<Map<String, dynamic>> tables =
      await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');

  for (var table in tables) {
    final tableName = table['name'];

    if (tableName != 'sqlite_sequence' && tableName != 'android_metadata') {
      await db.execute('DROP TABLE IF EXISTS $tableName');
    }
  }
}

Future<List<Map<String, dynamic>>> checkTablePragma() async {
  final db = await open();
  final List<Map<String, dynamic>> result =
      await db.rawQuery('PRAGMA table_info(subjects)');
  return result;
}

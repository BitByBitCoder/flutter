import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqlite/sqflite/models.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _db;

  DatabaseHelper._instance();

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colContent = 'content';

  Future<Database?> get db async {
    _db ??= await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $noteTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colTitle TEXT,
        $colContent TEXT
      )
    ''');
  }

  Future<int> addNote(NoteModel noteModel) async {
    final db = await instance.db;
    return await db!.insert(noteTable, noteModel.toMap());
  }

  Future<List<NoteModel>> getNotes() async {
    final db = await instance.db;
    final maps = await db!.query(noteTable);

    return maps.isNotEmpty
        ? maps.map((e) => NoteModel.fromMap(e)).toList()
        : [];
  }

  Future<int> updateNote(NoteModel noteModel) async {
    final db = await instance.db;
    return await db!.update(
      noteTable,
      noteModel.toMap(),
      where: '$colId = ?',
      whereArgs: [noteModel.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.db;
    return await db!.delete(
      noteTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
  }
}

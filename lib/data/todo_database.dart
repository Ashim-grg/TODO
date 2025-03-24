import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_bloc/models/todo_model.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;

  TodoDatabase._init();
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 2, // Incremented version to 2
      onCreate: _createDB,
      onUpgrade: _onUpgrade, // Added onUpgrade to handle schema changes
    );
  }

Future<void> _createDB(Database db, int version) async {
  await db.execute(
    '''
    CREATE TABLE todos(
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      details TEXT,  
      time TEXT NOT NULL,
      iscompleted INTEGER NOT NULL
    )
    '''
  );
}


  // Schema migration logic
Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    // Check if the 'details' column exists, if not, add it
    var result = await db.rawQuery('PRAGMA table_info(todos)');
    bool hasDetailsColumn = result.any((col) => col['name'] == 'details');
    if (!hasDetailsColumn) {
      await db.execute('ALTER TABLE todos ADD COLUMN details TEXT');
    }
    
    // Check if the 'iscompleted' column exists, if not, add it
    bool hasIsCompletedColumn = result.any((col) => col['name'] == 'iscompleted');
    if (!hasIsCompletedColumn) {
      await db.execute('ALTER TABLE todos ADD COLUMN iscompleted INTEGER');
    }
  }
}

Future<void> deleteDatabase() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'todo.db');
  await databaseFactory.deleteDatabase(path); 
  _database = null; 
}


  Future<void> insertTodo(TodoModel todo) async {
    final db = await instance.database;
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await instance.database;
    final result = await db.query('todos');
    return result.map((json) => TodoModel.fromMap(json)).toList();
  }

  Future<void> updateTodo(TodoModel todo) async {
    final db = await instance.database;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id=?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    final db = await instance.database;
    await db.delete(
      'todos',
      where: 'id=?',
      whereArgs: [id],
    );
  }
}

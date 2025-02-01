import 'package:flutter_posts_app/data/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'posts.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE posts(
            id INTEGER PRIMARY KEY,
            title TEXT,
            body TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertPosts(List<Post> posts) async {
    final db = await database;
    final batch = db.batch();

    for (var post in posts) {
      if (post.id != null) {
        if (post.id! > 0) {
          // Only insert if id is not null
          // Only insert if id is greater than zero
          batch.insert(
            'posts',
            post.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    }

    await batch.commit();
  }

  Future<List<Post>> getPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('posts');

    return maps.map((map) => Post.fromMap(map)).toList();
  }

  Future<Post?> getPostById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Post.fromMap(maps.first);
    }
    return null;
  }
}

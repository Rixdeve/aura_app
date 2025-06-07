import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../models/cart_item.dart';

class CartDatabase {
  CartDatabase._init();
  static final CartDatabase instance = CartDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return Future.value(_database);
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        await _createDB(db, newVersion); // optional: call _createDB here too
      },
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE cart ADD COLUMN userId TEXT');
    }
  }

  Future _createDB(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS cart');
    await db.execute('''
    CREATE TABLE cart(
      id TEXT PRIMARY KEY,
      name TEXT,
      image TEXT,
      price INTEGER,
      quantity INTEGER,
      userId TEXT
    )
  ''');
  }

  Future<void> insertItem(CartItem item) async {
    final db = await instance.database;

    final existing = await db.query(
      'cart',
      where: 'id = ?',
      whereArgs: [item.id],
    );

    if (existing.isEmpty) {
      await db.insert('cart', item.toMap());
      print("Item inserted: ${item.name}");
    } else {
      final current = CartItem.fromMap(existing.first);
      await db.update(
        'cart',
        {'quantity': current.quantity + 1},
        where: 'id = ?',
        whereArgs: [item.id],
      );
      print("Item updated: ${item.name}, quantity: ${current.quantity + 1}");
    }
  }

  Future<void> clearCartByUser(String userId) async {
    final db = await instance.database;
    await db.delete('cart', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<List<CartItem>> getCartItemsByUser(String userId) async {
    final db = await instance.database;
    final result = await db.query(
      'cart',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((e) => CartItem.fromMap(e)).toList();
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }

  Future<void> updateItem(CartItem item) async {
    final db = await instance.database;
    await db.update(
      'cart',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

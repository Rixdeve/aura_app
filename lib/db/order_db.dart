import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cart_item.dart';
import '../models/report.dart';

class OrderDatabase {
  OrderDatabase._init();
  static final OrderDatabase instance = OrderDatabase._init();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        order_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        name TEXT,
        email TEXT,
        phone TEXT,
        address TEXT,
        location TEXT,
        total INTEGER
      );
    ''');

    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER,
        product_id TEXT,
        name TEXT,
        image TEXT,
        price INTEGER,
        quantity INTEGER,
        FOREIGN KEY(order_id) REFERENCES orders(order_id)
      );
    ''');
    await db.execute('''
    CREATE TABLE reports (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      order_id INTEGER,
      description TEXT,
      image_path TEXT,
      created_at TEXT,
      FOREIGN KEY(order_id) REFERENCES orders(order_id)
    );
  ''');
  }

  Future<void> insertReport(Report report) async {
    final db = await database;
    await db.insert('reports', report.toMap());
  }

  Future<int> insertOrder({
    required String userId,
    required String name,
    required String email,
    required String phone,
    required String address,
    required String location,
    required int total,
    required List<CartItem> items,
  }) async {
    final db = await database;

    final orderId = await db.insert('orders', {
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'location': location,
      'total': total,
    });

    for (final item in items) {
      await db.insert('order_items', {
        'order_id': orderId,
        'product_id': item.id,
        'name': item.name,
        'image': item.image,
        'price': item.price,
        'quantity': item.quantity,
      });
    }

    return orderId;
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future<List<Map<String, dynamic>>> getOrdersWithItems() async {
    final db = await database;
    final result = await db.rawQuery('''
    SELECT o.order_id, o.name AS customer_name, o.total, o.date, oi.name AS product_name
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    ORDER BY o.order_id DESC
  ''');
    return result;
  }
}

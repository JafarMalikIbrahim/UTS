import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDb {
  static final SqfliteDb _instance = SqfliteDb._instance;
  Database? _database;
  SqfliteDb._internal();
  factory SqfliteDb() => _instance;

  // inisialisasi variabel yang dibutuhkan
  final String tableMekanik = 'mekanik';
  final String columnId = 'id';
  final String spd11 = 'spd11';
  final String spd12 = 'spd12';
  final String spd13 = 'spd13';
  final String spd14 = 'spd14';
  final String spd15 = 'spd15';
  final String lokasi = 'lokasi';
  final String tglPasang = 'tglPasang';

  // cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'manajemenAset.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableMekanik($columnId INTEGER PRIMARY KEY,"
        "$columnId TEXT,"
        "$spd11 TEXT,"
        "$spd12 TEXT,"
        "$spd13 TEXT,"
        "$spd14 TEXT,"
        "$spd15 TEXT,"
        "$lokasi TEXT,"
        "$tglPasang TEXT,";
    await db.execute(sql);
  }
}

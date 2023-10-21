import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/db/activity_db_model.dart';
import '../../domain/models/db/mapaton_db_model.dart';
import '../../domain/models/db/mapper_db_model.dart';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textNotNullType = 'TEXT NOT NULL';
  final textType = 'TEXT';
  final integerNotNullType = 'INTEGER NOT NULL';
  final integerType = 'INTEGER';
  final floatNotNullType = 'FLOAT NOT NULL';
  final floatType = 'FLOAT';
  final boolNotNullType = 'BOOLEAN NOT NULL';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('ecozonas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);//, onUpgrade: _upgradeDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $mappersTable (
        ${MapperColumns.id} $idType,
        ${MapperColumns.mapperId} $integerNotNullType,
        ${MapperColumns.alias} $textNotNullType,
        ${MapperColumns.gender} $textNotNullType,
        ${MapperColumns.age} $textNotNullType,
        ${MapperColumns.disability} $textNotNullType
      )
    ''');

    await db.execute('''
      CREATE TABLE $mapatonsTable (
        ${MapatonColumns.id} $idType,
        ${MapatonColumns.uuid} $textNotNullType,
        ${MapatonColumns.dateTime} $textNotNullType,
        ${MapatonColumns.mapperId} $integerNotNullType,
        ${MapatonColumns.mapperGender} $textNotNullType,
        ${MapatonColumns.mapperAge} $integerNotNullType,
        ${MapatonColumns.mapperDisability} $textNotNullType
      )
    ''');

    await db.execute('''
      CREATE TABLE $activitiesTable (
        ${ActivityColumns.id} $idType,
        ${ActivityColumns.mapatonId} $integerNotNullType,
        ${ActivityColumns.uuid} $textNotNullType,
        ${ActivityColumns.latitude} $floatNotNullType,
        ${ActivityColumns.longitude} $floatNotNullType,
        ${ActivityColumns.timestamp} $textNotNullType,
        ${ActivityColumns.blocks} $textNotNullType
      )
    ''');
  }

  // Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < newVersion) {
  //     db.execute("ALTER TABLE $shoppingListsTable ADD COLUMN ${ShoppingListColumns.latitude} $floatType");
  //   }
  // }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  /*
   * GENERIC
   */
  Future<int> insert(String table, Map<String, dynamic> map) async {
    final db = await instance.database;
    
    return await db.insert(table, map);    
  }

  Future<Map<String, dynamic>?> getById(String table, int id) async {
    final db = await instance.database;

    final result = await db.query(
      table,
      where: '_id = ?',
      whereArgs: [id],
      limit: 1
    );

    return result.isNotEmpty ? result[0] : null;
  }

  Future<List<Map<String, dynamic>>?> getAll(String table) async {
    final db = await instance.database;

    // const orderBy = '${MyShoppingListCols.id} ASC';
    return await db.query(table);//, orderBy: orderBy);
  }

  Future<Map<String, dynamic>?> getMapatonByUuidAndMapper(String table, String uuid, String mapperId) async {
    final db = await instance.database;

    final result = await db.rawQuery('''
      SELECT * FROM $table
      WHERE uuid = '$uuid' AND mapperId = '$mapperId'
      LIMIT 1;
    ''');

    final list = result.toList();

    return list.isNotEmpty ? list[0] : null;
  }

  Future<List<Map<String, dynamic>>?> getMapatonActivities(String table, int mapatonId) async {
    final db = await instance.database;

    return await db.query(
      table,
      where: '${ActivityColumns.mapatonId} = ?',
      whereArgs: [mapatonId]
    );
  }

  // Future<List<Map<String, dynamic>>?> getProductsByListId(String table, int listId) async {
  //   final db = await instance.database;

  //   return await db.query(
  //     table,
  //     where: '${ProductByListColumns.listId} = ?',
  //     whereArgs: [listId],
  //     orderBy: '${ProductByListColumns.selected} ASC, ${ProductByListColumns.position} ASC'
  //   );
  // }

  // Future<double> getNewPosition(String table, int listId) async {
  //   final db = await instance.database;

  //   final result = await db.rawQuery('''
  //     SELECT * FROM $table
  //     WHERE listId = $listId
  //     ORDER BY position DESC
  //     LIMIT 1;
  //   ''');

  //   final list = result.map((e) {
  //     return ProductsByListModel.fromMap(e);
  //   }).toList();

  //   return list.isEmpty ? 1 : list[0].position + 1;
  // }

  Future<int> update(String table, int id, Map<String, dynamic> map) async {
    final db = await instance.database;

    return db.update(
      table,
      map,
      where: '_id = ?',
      whereArgs: [id]
    );
  }

  Future<int> delete(String table, int id) async {
    final db = await instance.database;

    return await db.delete(
      table,
      where: '_id = ?',
      whereArgs: [id]
    );
  }
}
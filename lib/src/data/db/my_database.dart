import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/db/activity_db_model.dart';
import '../../domain/models/db/mapaton_db_model.dart';
import '../../domain/models/db/mapaton_data_db_model.dart';
import '../../domain/models/db/mapper_db_model.dart';
import '../../domain/models/db/survey_data_db_model.dart';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  /// Ruta de la base en las pruebas (por ejemplo, inMemoryDatabasePath).
  @visibleForTesting
  static String? pathOverride;

  /// Cierra la base y la olvida, para que cada prueba empiece de cero.
  @visibleForTesting
  static Future<void> reset() async {
    await _database?.close();
    _database = null;
  }

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
    final path = pathOverride ?? join(await getDatabasesPath(), filePath);

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
        ${ActivityColumns.name} $textNotNullType,
        ${ActivityColumns.color} $textNotNullType,
        ${ActivityColumns.borderColor} $textNotNullType,
        ${ActivityColumns.latitude} $floatNotNullType,
        ${ActivityColumns.longitude} $floatNotNullType,
        ${ActivityColumns.timestamp} $textNotNullType,
        ${ActivityColumns.blocks} $textNotNullType,
        ${ActivityColumns.categoryCode} $textNotNullType,
        ${ActivityColumns.sent} $boolNotNullType
      )
    ''');

    await db.execute('''
      CREATE TABLE $mapatonsListTable (
        ${MapatonDataColumns.id} $idType,
        ${MapatonDataColumns.data} $textNotNullType
      )
    ''');

    await db.execute('''
      CREATE TABLE $surveyListTable (
        ${SurveyDataColumns.id} $idType,
        ${SurveyDataColumns.data} $textNotNullType
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

    final result = await db.query(
      table,
      where: '${MapatonColumns.uuid} = ? AND ${MapatonColumns.mapperId} = ?',
      whereArgs: [uuid, mapperId],
      limit: 1
    );

    return result.isNotEmpty ? result[0] : null;
  }

  Future<List<Map<String, dynamic>>?> getMapatonActivities(String table, int mapatonId) async {
    final db = await instance.database;

    return await db.query(
      table,
      where: '${ActivityColumns.mapatonId} = ?',
      whereArgs: [mapatonId]
    );
  }

  Future<List<Map<String, dynamic>>?> getMapatonActivitiesToSend(String table, int mapatonId) async {
    final db = await instance.database;

    return await db.query(
      table,
      where: '${ActivityColumns.mapatonId} = ? AND ${ActivityColumns.sent} = 0',
      whereArgs: [mapatonId]
    );
  }

  Future updateSentActivities(int mapatonId) async {
    final db = await instance.database;

    await db.update(
      activitiesTable,
      {ActivityColumns.sent: 1},
      where: '${ActivityColumns.mapatonId} = ? AND ${ActivityColumns.sent} = 0',
      whereArgs: [mapatonId]
    );
  }

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
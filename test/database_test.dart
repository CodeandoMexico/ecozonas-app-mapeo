import 'dart:io';

import 'package:ecozonas/src/data/db/my_database.dart';
import 'package:ecozonas/src/domain/models/db/activity_db_model.dart';
import 'package:ecozonas/src/domain/models/db/mapaton_db_model.dart';
import 'package:ecozonas/src/domain/models/db/mapper_db_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    MyDatabase.pathOverride = inMemoryDatabasePath;
    await MyDatabase.reset();
  });

  tearDown(MyDatabase.reset);

  Future<int> insertMapaton({required String uuid, required int mapperId}) {
    return MyDatabase.instance.insert(mapatonsTable, {
      MapatonColumns.uuid: uuid,
      MapatonColumns.dateTime: '2026-11-26',
      MapatonColumns.mapperId: mapperId,
      MapatonColumns.mapperGender: 'MUJER',
      MapatonColumns.mapperAge: '18_25',
      MapatonColumns.mapperDisability: 'NINGUNA',
    });
  }

  Future<int> insertActivity({required int mapatonId, bool sent = false}) {
    return MyDatabase.instance.insert(activitiesTable, {
      ActivityColumns.mapatonId: mapatonId,
      ActivityColumns.uuid: 'actividad',
      ActivityColumns.name: 'Puntos de internet',
      ActivityColumns.color: '#FFFFFF',
      ActivityColumns.borderColor: '#000000',
      ActivityColumns.latitude: 19.43,
      ActivityColumns.longitude: -99.13,
      ActivityColumns.timestamp: '2026-11-26 12:00:00Z',
      ActivityColumns.blocks: '[]',
      ActivityColumns.categoryCode: 'ENTORNO_URBANO',
      ActivityColumns.sent: sent ? 1 : 0,
    });
  }

  group('getMapatonByUuidAndMapper', () {
    test('encuentra el mapatón por uuid y mapperId (que llega como texto)', () async {
      final id = await insertMapaton(uuid: 'abc', mapperId: 7173);

      final row = await MyDatabase.instance.getMapatonByUuidAndMapper(mapatonsTable, 'abc', '7173');

      expect(row?[MapatonColumns.id], id);
    });

    test('un apóstrofo en el uuid ya no rompe la consulta', () async {
      final id = await insertMapaton(uuid: "o'brien", mapperId: 1);

      final row = await MyDatabase.instance.getMapatonByUuidAndMapper(mapatonsTable, "o'brien", '1');

      expect(row?[MapatonColumns.id], id);
    });

    test('no confunde mapatones de otro mapeador', () async {
      await insertMapaton(uuid: 'abc', mapperId: 1);

      final row = await MyDatabase.instance.getMapatonByUuidAndMapper(mapatonsTable, 'abc', '2');

      expect(row, isNull);
    });
  });

  test('las actividades por enviar se marcan como enviadas solo en su mapatón', () async {
    await insertActivity(mapatonId: 1);
    await insertActivity(mapatonId: 1);
    await insertActivity(mapatonId: 1, sent: true);
    await insertActivity(mapatonId: 2);

    expect(await MyDatabase.instance.getMapatonActivitiesToSend(activitiesTable, 1), hasLength(2));

    await MyDatabase.instance.updateSentActivities(1);

    expect(await MyDatabase.instance.getMapatonActivitiesToSend(activitiesTable, 1), isEmpty);
    expect(await MyDatabase.instance.getMapatonActivitiesToSend(activitiesTable, 2), hasLength(1));
  });

  group('migraciones', () {
    test('hay una migración para cada versión después de la 1', () {
      for (var version = 2; version <= MyDatabase.schemaVersion; version++) {
        expect(MyDatabase.migrations.containsKey(version), isTrue, reason: 'falta la migración a $version');
      }
    });

    test('se aplican en orden y solo las que faltan', () async {
      final applied = <int>[];
      final migrations = <int, Migration>{
        for (final v in [2, 3, 4]) v: (_) async => applied.add(v),
      };
      final db = await MyDatabase.instance.database;

      await MyDatabase.migrate(db, 2, 4, migrations);

      expect(applied, [3, 4]);
    });

    test('una migración faltante falla con un error claro', () async {
      final db = await MyDatabase.instance.database;

      expect(() => MyDatabase.migrate(db, 1, 2, {}), throwsStateError);
    });

    test('una base existente conserva sus datos al actualizarse', () async {
      final dir = await Directory.systemTemp.createTemp('ecozonas_db_');
      addTearDown(() => dir.delete(recursive: true));
      final path = '${dir.path}/ecozonas.db';

      // Instalación con la versión actual del esquema y un mapeador guardado.
      MyDatabase.pathOverride = path;
      await MyDatabase.instance.insert(mappersTable, {
        MapperColumns.mapperId: 7173,
        MapperColumns.alias: '',
        MapperColumns.gender: 'MUJER',
        MapperColumns.age: '18_25',
        MapperColumns.disability: 'NINGUNA',
      });
      await MyDatabase.reset();

      // Una versión futura de la app agrega una columna.
      const next = MyDatabase.schemaVersion + 1;
      final db = await databaseFactory.openDatabase(path, options: OpenDatabaseOptions(
        version: next,
        onUpgrade: (db, oldVersion, newVersion) => MyDatabase.migrate(db, oldVersion, newVersion, {
          next: (db) => db.execute('ALTER TABLE $mappersTable ADD COLUMN extra TEXT'),
        }),
      ));
      addTearDown(db.close);

      final rows = await db.query(mappersTable);
      expect(rows, hasLength(1));
      expect(rows.first[MapperColumns.mapperId], 7173);
      expect(rows.first.containsKey('extra'), isTrue);
    });
  });
}

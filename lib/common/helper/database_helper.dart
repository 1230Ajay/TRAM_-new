import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../entities/data_entity.dart';
import '../entities/database.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    sqfliteFfiInit();

    // Set the databaseFactory for sqflite_common_ffi
    databaseFactory = databaseFactoryFfi;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'tram.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await createTables(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // Handle database upgrades if needed
      },
    );

    // Check if tables already exist, and if not, create them
    if (!(
        await tableExists(database, 'Recording') &&
        await tableExists(database, 'RecordingData'))) {
      await createTables(database);
    }

    return database;
  }

  Future<void> createTables(Database db) async {

    await db.execute('''
    CREATE TABLE Recording (
      id INTEGER PRIMARY KEY,
      name TEXT,
      dateTime TEXT,
      zone TEXT,
      section TEXT,
      division TEXT,
      direction TEXT,
      operator TEXT,
      sectionId INTEGER
    )
  ''');

    await db.execute('''
    CREATE TABLE RecordingData (
      id INTEGER PRIMARY KEY,
      recordingId INTEGER,
      dateTime TEXT,
      level TEXT,
      gauge TEXT,
      gradient TEXT,
      temp TEXT,
      actual_distance INTEGER,
      relative_distance INTEGER,
      twist TEXT,
      longitude TEXT,
      latitude TEXT,
      FOREIGN KEY (recordingId) REFERENCES Recording(id) ON DELETE CASCADE
    )
''');

  }

  Future<bool> tableExists(Database db, String tableName) async {
    var result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
    );
    return result.isNotEmpty;
  }


  Future<void> insertRecording({required RecordingEntity recording}) async {

    final Database db = await database;

      // Insert the recording with the sectionId
      await db.insert('Recording', {
        'name': recording.name,
        'dateTime': DateTime.now().toIso8601String(),
        'zone': recording.zone,
        'section': recording.section,
        'division': recording.division,
        'operator': recording.operator,
        'direction': recording.direction
      });

  }

  Future<void> deleteRecordings(List<int> recordingIds) async {
    final Database db = await database;

    // Delete report with matching IDs
    for (int id in recordingIds) {
      await db.delete(
        'Recording',
        where: 'id = ?',
        whereArgs: [id],
      );

      await db.delete(
        'RecordingData',
        where: 'recordingId = ?',
        whereArgs: [id],
      );
    }
  }


  Future<void> insertRecordingData({required RecordingDataEntity recordingData, required String recordingName}) async {
    final Database db = await database;


    // Find the recordingId based on the recordingName
    final List<Map<String, dynamic>> recordingResult = await db.query(
      'Recording',
      where: 'name = ?',
      whereArgs: [recordingName],
    );


    if (recordingResult.isNotEmpty) {
      final int recordingId = recordingResult.first['id'];
      // Insert the recording data with the recordingId
      await db.insert('RecordingData', {
        'recordingId': recordingId,
        'dateTime': DateTime.now().toIso8601String(),
        'level':recordingData.level,
        'gauge': recordingData.gauge,
        'gradient': recordingData.gradient,
        'temp': recordingData.temp,
        "relative_distance":recordingData.relative_distance,
        "actual_distance":recordingData.actual_distance,
        'twist': recordingData.twist,
        'longitude': recordingData.longitude,
        'latitude': recordingData.latitude,
      });
    }
  }

  Future<List<ZoneEntity>> getAllZones() async {
    final Database db = await database;
    List<Map<String, dynamic>> zones = await db.query('Zone');
    return zones.map((zone) => ZoneEntity.fromMap(zone)).toList();
  }

  Future<List<DivisionEntity>> getDivisionsForZone(String zoneName) async {
    final Database db = await database;

    final List<Map<String, dynamic>> zoneResult = await db.query(
      'Zone',
      where: 'name = ?',
      whereArgs: [zoneName],
    );

    if (zoneResult.isNotEmpty) {
      final int zoneId = zoneResult.first['id'];

      List<Map<String, dynamic>> divisions = await db.query(
        'Division',
        where: 'zoneId = ?',
        whereArgs: [zoneId],
      );

      return divisions.map((division) => DivisionEntity.fromMap(division)).toList();
    }

    return [];
  }

  Future<List<RecordingEntity>> getAllRecordings() async {
    final Database db = await database;
    List<Map<String, dynamic>> recordings = await db.query('Recording');

     List<RecordingEntity> recordings_list= recordings.map((recording) => RecordingEntity.fromMap(recording)).toList();
    return recordings_list;
  }


  Future<List<SectionEntity>> getSectionsForDivision(String divisionName) async {
    final Database db = await database;

    final List<Map<String, dynamic>> divisionResult = await db.query(
      'Division',
      where: 'name = ?',
      whereArgs: [divisionName],
    );

    if (divisionResult.isNotEmpty) {
      final int divisionId = divisionResult.first['id'];

      List<Map<String, dynamic>> sections = await db.query(
        'Section',
        where: 'divisionId = ?',
        whereArgs: [divisionId],
      );

      return sections.map((section) => SectionEntity.fromMap(section)).toList();
    }

    return [];
  }

  Future<List<RecordingEntity>> getRecordingByName(String recordingName) async {
    final Database db = await database;

    print("------------------------------searching for recording name ${recordingName}");

    final List<Map<String, dynamic>> recordingResult = await db.query(
      'Recording',
      where: 'name = ?',
      whereArgs: [recordingName],
    );

    print(recordingResult.toString());

    if(recordingResult.isNotEmpty){
      return recordingResult.map((data) => RecordingEntity.fromMap(data)).toList();
    }

    return [];
  }


  Future<List<RecordingDataEntity>> getRecordingsForName(String recordingName) async {
    final Database db = await database;



    final List<Map<String, dynamic>> recordingResult = await db.query(
      'Recording',
      where: 'name = ?',
      whereArgs: [recordingName],
    );

    print("print recordcing search result : ${recordingResult}");

    if (recordingResult.isNotEmpty) {
      final int recordingId = recordingResult.first['id'];

      List<Map<String, dynamic>> recordingDataList = await db.query(
        'RecordingData',
        where: 'recordingId = ?',
        whereArgs: [recordingId],
      );

      print("data for that recording name : ${recordingDataList}");

      List<RecordingDataEntity> recordingData = recordingDataList.map((data) => RecordingDataEntity.fromMap(data)).toList();

      // Get recording details

        return recordingData;
    }

    return [];
  }



  Future<int> getLastRelativeDistance(String recordingName) async {
    final Database db = await database;

    final List<Map<String, dynamic>> recordingResult = await db.query(
      'Recording',
      where: 'name = ?',
      whereArgs: [recordingName],
    );

    print("you got recording name to find last row : ${recordingName}");

    if (recordingResult.isNotEmpty) {
      final int recordingId = recordingResult.first['id'];

      List<Map<String, dynamic>> recordingDataList = await db.query(
        'RecordingData',
        where: 'recordingId = ?',
        whereArgs: [recordingId],
      );



      if (recordingDataList.isNotEmpty) {
        // Get the last row and return its relative_distances value
        print("you got recording name to find last row : ${recordingDataList.last}");
        return recordingDataList.last['relative_distance'];
      }
    }

    // Return null if no data is found
    return 0;
  }



}




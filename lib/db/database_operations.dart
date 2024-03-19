import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trapp/db/package_name_entity.dart';

import '../constants.dart';

class DatabaseOperations {
  late final Database? _database;

  Database? get database => _database;

  Future<void> initializeDatabase() async {
    if (_database == null) {
      final dbsPath = await getDatabasesPath();
      final packageNameDbPath = join(dbsPath, packageNameDbName);
      _database = await openDatabase(
          packageNameDbPath,
          onCreate: (db, version) =>
              db.execute("CREATE TABLE IF NOT EXISTS ${packageNameTable}(name TEXT PRIMARY KEY)"),
          version: 1);
    }
  }

  Future<List<PackageNameEntity>> retrieveAll() async {
    await initializeDatabase();
    final List<Map<String, Object?>> allPackageNames = await _database!.query(
        packageNameTable);
    return allPackageNames.map(PackageNameEntity.fromMap).toList();
  }

  Future<int> insert(PackageNameEntity packageNameEntity) async {
    await initializeDatabase();
    return _database!.insert(packageNameTable, packageNameEntity.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> delete(PackageNameEntity packageNameEntity) async {
    await initializeDatabase();
    return _database!.delete(packageNameTable, where: "name = ?", whereArgs: [packageNameEntity.packageName]);
  }

}

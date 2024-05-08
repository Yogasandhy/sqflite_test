import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tes_cappela/model.dart';

class DatabaseInstance {
  final String _databasename = 'mydb.db';
  final int databaseversion = 1;

  final String table = 'Capella';
  final String UserId = 'UserId';
  final String Nama = 'Nama';
  final String TanggalLahir = 'TanggalLahir';
  final String Password = 'Password';
  final String RegisterDateTime = 'RegisterDateTime';
  final String StatusLogin = 'StatusLogin';
  final String LoginDateTime = 'LoginDateTime';
  final String LogoutDateTime = 'LogoutDateTime';
  final String Email = 'Email';
  final String KonfirmasiPassword = 'KonfirmasiPassword';
  final String alamat = 'alamat';
  final String namaLengkap = 'namaLengkap';
  final String nomorTelepon = 'nomorTelepon';

  Database? _database;
  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initdatabase();
    return _database!;
  }

  Future _initdatabase() async {
    Directory documentDirectory = await getApplicationCacheDirectory();
    String path = join(documentDirectory.path, _databasename);
    return openDatabase(path, version: databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table ($UserId INTEGER PRIMARY KEY, $Nama TEXT NULL, $TanggalLahir TEXT NULL, $Password TEXT, $RegisterDateTime TEXT NULL, $StatusLogin TEXT NULL,$LoginDateTime TEXT NULL, $LogoutDateTime TEXT NULL, $Email TEXT, $KonfirmasiPassword TEXT, $alamat TEXT, $nomorTelepon TEXT, $namaLengkap TEXT)');
  }

  Future<List<Model>> all() async {
    final data = await _database!.query(table);
    List<Model> result = data.map((e) => Model.fromJson(e)).toList();
    print(result);
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final query = await _database!.insert(table, row);
    print(query);
    return query;
  }

  Future<Model> getusers(String email, String password) async {
    List<Map> maps = await _database!.query(table,
        columns: [UserId, Email, Password, Nama],
        where: '$Email = ? AND $Password = ?',
        whereArgs: [email, password]);
    if (maps.length > 0) {
      Model user = Model.fromJson(maps.first.cast<String, dynamic>());
      print('User ID: ${user.UserId}');
      await _database!.update(
        table,
        {
          'StatusLogin': 'logged in',
          'LoginDateTime': DateTime.now().toString(),
        },
        where: '$UserId = ?',
        whereArgs: [user.UserId],
      );
      return user;
    } else {
      throw Exception('User not found');
    }
  }

  Future<Model?> getUserByEmail(String email) async {
    List<Map> maps = await _database!.query(table,
        columns: [UserId, Email, Password, Nama],
        where: '$Email = ?',
        whereArgs: [email]);
    if (maps.length > 0) {
      return Model.fromJson(maps.first.cast<String, dynamic>());
    } else {
      return null;
    }
  }

  Future<List<Model>> getAllCustomers() async {
    final data = await _database!.query(table);
    List<Model> customers = data.map((e) => Model.fromJson(e)).toList();
    return customers;
  }

  Future<int> update(Map<String, dynamic> row, int userId) async {
  return await _database!.update(
    table,
    row,
    where: '$UserId = ?',
    whereArgs: [userId],
  );
}


  Future<void> logout(int userId) async {
    _database ??= await _initdatabase();
    int result = await _database!.update(
      table,
      {
        'StatusLogin': 'logged out',
        'LogoutDateTime': DateTime.now().toString(),
      },
      where: '$UserId = ?',
      whereArgs: [userId],
    );
    print('Logout id: $userId, $result');
  }
}

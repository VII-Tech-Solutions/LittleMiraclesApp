import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    //sample for local db update
    // void _upgradeToV2(Batch batch) {
    //   batch.execute('ALTER TABLE students ADD COLUMN email TEXT;');
    // }

    return sql.openDatabase(
      path.join(dbPath, 'little_miracles.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE onboardings(id INT PRIMARY KEY, updatedAt TEXT, deletedAt TEXT, title TEXT, content TEXT, image TEXT, orderNum INTEGER)');
        await db.execute(
            'CREATE TABLE dailyTips(id INT PRIMARY KEY, status INTEGER, updatedAt TEXT, deletedAt TEXT, image TEXT, title TEXT, postedAt TEXT, content TEXT)');
        await db.execute(
            'CREATE TABLE promotions(id INT PRIMARY KEY, image TEXT, title TEXT, offer TEXT, type TEXT, content TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT, postedAt TEXT, validUntil TEXT, promoCode TEXT)');
        await db.execute(
            'CREATE TABLE workshops(id INT PRIMARY KEY, image TEXT, title TEXT, price TEXT, content TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT, postedAt TEXT)');
        await db.execute(
            'CREATE TABLE sections(id INT PRIMARY KEY, image TEXT, title TEXT, content TEXT, status INTEGER, type INTEGER, actionText TEXT, goTo TEXT, updatedAt TEXT, deletedAt TEXT, isFeatured INTEGER)');
        await db.execute(
            'CREATE TABLE packages(id INT PRIMARY KEY, title TEXT, tag TEXT, image TEXT, price TEXT, isPopular INTEGER, type INTEGER, content TEXT, locationText TEXT, locationLink TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE backdrops(id INT PRIMARY KEY, title TEXT, category TEXT, image TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE cakes(id INT PRIMARY KEY, title TEXT, category TEXT, image TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE photographers(id INT PRIMARY KEY, name TEXT, image TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE familyMember(id INT PRIMARY KEY, familyId INTEGER, firstName TEXT, lastName TEXT, gender INTEGER, birthDate TEXT, relationship INTEGER, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
      },
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) async {
        print(
            'OLD VERSION = ${oldVersion.toString()} NEW VERSION, = ${newVersion.toString()}');
        var batch = db.batch();

        // if (oldVersion < 2) {
        //   print('Upgrading to V2');
        //   _upgradeToV2(batch);
        // }

        await batch.commit();
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getAllData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table, where: 'id>=0');
  }

  static Future<List<Map<String, dynamic>>> getStudentPosts(
      int studentID) async {
    final db = await DBHelper.database();
    return db.query('posts', where: 'student_id==' + studentID.toString());
  }

  static Future<List<Map<String, dynamic>>> findImg(String studentid) async {
    final db = await DBHelper.database();
    return db.query('students', where: 'id=$studentid', columns: ['picture']);
  }

  static Future<List<Map<String, dynamic>>> getDataById(
      String table, String column, int id) async {
    final db = await DBHelper.database();
    return db.query(table, where: '$column = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> read(
      String table, String userid, String notid) async {
    final db = await DBHelper.database();
    return db.query(table,
        where: 'userid=' + userid + ' and noticeid=' + notid);
  }

  static Future<List<Map<String, dynamic>>> getStudentAttendance(
      String table, String id) async {
    final db = await DBHelper.database();
    return db.query(table, distinct: true, where: 'id = ' + id);
  }

  static Future<List<Map<String, dynamic>>> getStudentAbsentDates(
      String table, String id) async {
    final db = await DBHelper.database();
    return db.query(table, where: 'userid = ' + id);
  }

  static Future<List<Map<String, dynamic>>> getDistinctYear(
      String table, String id) async {
    final db = await DBHelper.database();
    return db.query(table,
        distinct: true, columns: ['year'], where: 'userid = ' + id);
  }

  static Future<List<Map<String, dynamic>>> getDistinctDate(
      String table) async {
    final db = await DBHelper.database();
    return db.query(table,
        distinct: true, columns: ['Date(start_date) as start_date']);
  }

  // static Future<List<Map<String, dynamic>>> getEventTitles(
  //     String table, DateTime date) async {
  //   final db = await DBHelper.database();
  //   return db.query(table,
  //       distinct: true, columns: ['title']);
  // }

  static Future<int> update(
    String table,
    dynamic object,
  ) async {
    final db = await DBHelper.database();
    return db
        .update(table, object.toMap(), where: 'id = ?', whereArgs: [object.id]);
  }

  // static Future<List<Map<String, dynamic>>> updateData(String table) async {
  //   final db = await DBHelper.database();
  //   return db.update(table, values);
  // }
  // static Future<List<Map<String, dynamic>>> updateData(String table) async {
  //   final db = await DBHelper.database();
  //   return db.
  // }

  static Future<int> deleteTable(String table) async {
    final db = await DBHelper.database();
    return db.delete(table);
  }

  static Future<int> deleteById(String table, int id) async {
    final db = await DBHelper.database();
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> deleteAllForUser(String table, String where) async {
    final db = await DBHelper.database();
    return db.delete(table, where: where);
  }
}

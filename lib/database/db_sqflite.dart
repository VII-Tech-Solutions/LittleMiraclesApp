//PACKAGES
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
//EXTENSIONS
//GLOBAL
import '../global/const.dart';
//MODELS
//PROVIDERS
//WIDGETS
//PAGES

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
            'CREATE TABLE ${Tables.onboarding}(id INT PRIMARY KEY, updatedAt TEXT, deletedAt TEXT, title TEXT, content TEXT, image TEXT, orderNum INTEGER)');
        await db.execute(
            'CREATE TABLE ${Tables.dailyTips}(id INT PRIMARY KEY, status INTEGER, updatedAt TEXT, deletedAt TEXT, image TEXT, title TEXT, postedAt TEXT, content TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.promotions}(id INT PRIMARY KEY, image TEXT, title TEXT, offer TEXT, type INTEGER, content TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT, postedAt TEXT, validUntil TEXT, promoCode TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.workshops}(id INT PRIMARY KEY, image TEXT, title TEXT, price TEXT, content TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT, postedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.sections}(id INT PRIMARY KEY, image TEXT, title TEXT, content TEXT, status INTEGER, type INTEGER, actionText TEXT, goTo TEXT, updatedAt TEXT, deletedAt TEXT, isFeatured INTEGER)');
        await db.execute(
            'CREATE TABLE ${Tables.packages}(id INT PRIMARY KEY, title TEXT, tag TEXT, image TEXT, price TEXT, isPopular INTEGER, type INTEGER, content TEXT, locationText TEXT, locationLink TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT, backdropAllowed INTEGER, cakeAllowed INTEGER, outdoorAllowed INTEGER, hasGuideline INTEGER, benefitsIds TEXT, subPackagesIds TEXT, reviewsIds TEXT, mediaIds TEXT, totalReviews INTEGER, rating REAL)');
        await db.execute(
            'CREATE TABLE ${Tables.backdrops}(id INT PRIMARY KEY, title TEXT, categoryId INTEGER, image TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.cakes}(id INT PRIMARY KEY, title TEXT, categoryId INTEGER, image TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.photographers}(id INT PRIMARY KEY, name TEXT, image TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.familyMembers}(id INT PRIMARY KEY, familyId INTEGER, firstName TEXT, lastName TEXT, gender INTEGER, birthDate TEXT, relationship INTEGER, status INTEGER, phoneNumber TEXT, countryCode TEXT, personality TEXT, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.familyInfo}(id INT PRIMARY KEY, userId INTEGER, familyId INTEGER, questionId INTEGER, answer TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.paymentMethods}(id INT PRIMARY KEY, title TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.backdropCategories}(id INT PRIMARY KEY, name TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.cakeCategories}(id INT PRIMARY KEY, name TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.studioPackages}(id INT PRIMARY KEY, title TEXT, image TEXT, startingPrice TEXT, status INTEGER, type INTEGER, benefitIds TEXT, mediaIds TEXT, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.studioMetadata}(id INT PRIMARY KEY, title TEXT, price TEXT, description TEXT, image TEXT, status INTEGER, category INTEGER, updatedAt TEXT, deletedAt TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.sessions}(id INT PRIMARY KEY, title TEXT, userId INTEGER, familyId INTEGER, packageId INTEGER, customBackdrop TEXT, customCake TEXT, comments TEXT, totalPrice TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT, date TEXT, time TEXT, includeMe INTEGER, locationText TEXT, locationLink TEXT, isOutdoor INTEGER, formattedDate TEXT, formattedPeople TEXT, formattedBackdrop TEXT, formattedCake TEXT, photographerName TEXT, hasGuideline INTEGER, benefitsIds TEXT, reviewsIds TEXT, mediaIds TEXT)');
        await db.execute(
            'CREATE TABLE ${Tables.faqs}(id INT PRIMARY KEY, question TEXT, answer TEXT, status INTEGER, updatedAt TEXT, deletedAt TEXT)');
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

  static Future<int> deleteByColumnIntVal(
      String table, String column, int val) async {
    final db = await DBHelper.database();
    return db.delete(table, where: '$column = ?', whereArgs: [val]);
  }

  static Future<int> deleteAllForUser(String table, String where) async {
    final db = await DBHelper.database();
    return db.delete(table, where: where);
  }
}

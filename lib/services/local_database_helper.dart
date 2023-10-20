import 'package:get/get.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/model/db_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "LocalDB.db";

  static FormController formController = Get.find();

  static Future<Database> getDB() async {
    print("We initiate local db");
    // getAllNote();
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: ((db, version) async => await db.execute(
            'CREATE TABLE LocalData(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,firstName TEXT ,middleName TEXT ,surName TEXT ,phone TEXT ,gender TEXT ,address TEXT ,maritalStatus TEXT ,dob TEXT ,pollUnit TEXT , isSubmit INTEGER NOT NULL,wholelist TEXT NOT NULL,userid TEXT NOT NULL, subadminid TEXT NOT NULL, formid TEXT NOT NULL)')),
        version: _version);
  }

  static Future<int> addNote(DBDataModel dbDataModel) async {
    print("added initiate");

    final db = await getDB();

    return await db.insert("LocalData", dbDataModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(DBDataModel dbDataModel, String id) async {
    print("updated");
    final db = await getDB();
    return await db.update("LocalData", dbDataModel.toJson(),
        where: 'id=?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(String id) async {
    final db = await getDB();
    return await db.delete(
      "LocalData",
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<List<DBDataModel>?> getAllNote() async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query("LocalData");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => DBDataModel.fromJson(maps[index]));
  }

  static Future<List<DBDataModel>?> getSelectedNote(
      String userid, String formid) async {
    final db = await getDB();

    List<Map> maps = await db.rawQuery(
        'SELECT id, firstName, middleName, surName, phone, pollUnit,formid,gender,dob,maritalStatus FROM LocalData WHERE userid=? AND formid=? AND isSubmit=?',
        [userid, formid, 0]);

    formController.saveAndDrftList.clear();
    print("this is value of save and draft");
    print(formController.saveAndDrftList);
    if (maps.isEmpty) {
      return null;
    }

    try {
      if (maps.isNotEmpty) {
        for (var i in maps) {
          formController.saveAndDrftList.add(i);
        }
      }
    } catch (e) {
      (e);
    }
    print("after");
    print(formController.saveAndDrftList);

    return [];
  }

  static Future<List<DBDataModel>?> getSubmitteddNote(String userid) async {
    final db = await getDB();

    List<Map> maps = await db.rawQuery(
        'SELECT id, firstName, middleName, surName, phone, pollUnit,formid,gender,dob,maritalStatus FROM LocalData WHERE userid=? AND isSubmit=?',
        [userid, 1]);

    formController.userSubmittedDataList.clear();

    if (maps.isEmpty) {
      return null;
    }

    try {
      if (maps.isNotEmpty) {
        for (var i in maps) {
          formController.userSubmittedDataList.add(i);
        }
      }
    } catch (e) {
      (e);
    }
    print("user sumit ");
    print(formController.userSubmittedDataList);
    return [];
  }

  static Future<List<DBDataModel>?> getSingleNote(
      String userid, String formid, String id) async {
    final db = await getDB();

    var maps = await db.rawQuery(
        'SELECT * FROM LocalData WHERE userid=? AND formid=? AND id=?',
        [userid, formid, id]);

    if (maps.isEmpty) {
      return null;
    }

    try {
      if (maps.isNotEmpty) {
        for (var i in maps) {
          formController.editDrftList.add(i);
        }
      }
    } catch (e) {
      (e);
    }

    return [];
  }

  static Future<List<DBDataModel>?> getSingleSyncNote(String id) async {
    final db = await getDB();

    var maps = await db.rawQuery('SELECT * FROM LocalData WHERE id=?', [id]);

    if (maps.isEmpty) {
      return null;
    }

    try {
      if (maps.isNotEmpty) {
        for (var i in maps) {
          formController.syncDrftList.add(i);
        }
      }
    } catch (e) {
      (e);
    }

    return [];
  }

  static Future<int?> getDraftCount(String userid, String formid) async {
    final db = await getDB();

    var maps = await db.rawQuery(
        'SELECT count(*) as total FROM LocalData WHERE userid=? AND formid=? AND isSubmit=?',
        [userid, formid, 0]);

    int total = int.parse(maps[0]["total"].toString());

    return total;
  }

  // void getDraftCount(
  //     String userid, String formid, void Function(int?) callback) async {
  //   final db = await getDB();

  //   var maps = await db.rawQuery(
  //       'SELECT count(*) as total FROM LocalData WHERE userid=? AND formid=? AND isSubmit=?',
  //       [userid, formid, 0]);

  //   int total = int.parse(maps[0]["total"].toString());

  //   callback(total);
  // }

  static Future<List<DBDataModel>?> dropNote() async {
    final db = await getDB();
    await db.execute("DROP TABLE IF EXISTS LocalData");
    print("Drop table");
    return [];
  }
}

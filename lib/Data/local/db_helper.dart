import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  /// Singleton
  DbHelper._();

  static final DbHelper getInstance = DbHelper._();

  //Table note
  static final String TABLE_NOTES = "note";
  static final String COLUMN_NOTE_SNO = "s_no";
  static final String COLUMN_NOTE_TITLE = "title";
  static final String COLUMN_NOTE_DECS = "decs";

  Database? myDB;

  // db open (path -> if exits then open else create dp)
  Future<Database> getDB() async {
    myDB ??= await openDB();
    return myDB!;
    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await openDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, "noteDB.db");

    return await openDatabase(dbPath, onCreate: (db, version) {
      /// create all tables here
      db.execute(
          "create table $TABLE_NOTES ( $COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DECS text)");
      // create table
      // create table
      // create table
      // create table
    }, version: 1);
  }
  // all queries
  // insertion
Future<bool> addNote({required String mTitle, required String mDesc}) async{
    var db = await getDB();
    int rowsEffected = await db.insert(TABLE_NOTES, {COLUMN_NOTE_TITLE: mTitle, COLUMN_NOTE_DECS:mDesc});
    return rowsEffected>0;
}

///Reading all data
Future<List<Map<String, dynamic>>> getAllNotes() async{
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTES);
    return mData;
}
}

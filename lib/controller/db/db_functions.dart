import 'package:sqflite/sqflite.dart';
import 'package:student_app_provider/controller/constants/constants.dart';
import 'package:student_app_provider/model/student_model.dart';


class DbHelper {

static late Database _db;

static Future<void> initDatabase() async {
   _db = await openDatabase(
    "student.db",
    version: databaseVersion,
    onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tablename ($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $gname TEXT, $place TEXT, $phoneNumber INTEGER, $profilePic TEXT)');
    },
  );
}

static Future<int> addStudentToDb(Student student) async {
  return await _db.insert(tablename, {
    name: student.name,
    gname: student.guardianName,
    place: student.place,
    phoneNumber: student.phoneNumber,
    profilePic: student.profilePic,
  });
}

static Future<List<Student>> getStudents() async {
  final List<Map<String, dynamic>> values = await _db.rawQuery('SELECT * FROM $tablename');
  return List.generate(
      values.length,
      (index) => Student(
          id: values[index][id],
          name: values[index][name],
          guardianName: values[index][gname],
          place: values[index][place],
          phoneNumber: values[index][phoneNumber],
          profilePic: values[index][profilePic]));
}

static Future<int> updateStudent(Student student) async {
  return await _db.update(tablename, {
    name: student.name,
    gname:student.guardianName,
    place:student.place,
    phoneNumber:student.phoneNumber,
    profilePic:student.profilePic,
  },
  where: "$id = ?",whereArgs: [student.id],
  );
}
static Future<int> deleteStudentFromDb(int studentId) async {
  return await _db.delete(tablename,where: "$id = ?",whereArgs: [studentId]);
}
}
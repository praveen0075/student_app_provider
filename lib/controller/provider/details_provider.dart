import 'package:flutter/material.dart';
import 'package:student_app_provider/controller/db/db_functions.dart';

class DetailProvider extends ChangeNotifier{
  Future <void> deleteStudent(int studentId)async{
    await DbHelper.deleteStudentFromDb(studentId);
  }
}
import 'package:flutter/material.dart';
import 'package:student_app_provider/controller/db/db_functions.dart';
import 'package:student_app_provider/model/student_model.dart';

class HomeProvider extends ChangeNotifier{
   late DbHelper databaseHelper;
  List<Student> students = [];
  List<Student> filteredStudents = [];
  bool isSearching = false;

  HomeProvider() {
    databaseHelper = DbHelper();
    refreshStudentList();
  }

  Future<void> refreshStudentList() async {
    final studentList = await DbHelper.getStudents();
    students = studentList;
    filteredStudents = studentList;
    notifyListeners();
  }

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      filteredStudents = students;
    }
    notifyListeners();
  }

  void filterStudents(String query) {
    if (query.isEmpty) {
      filteredStudents = students;
    } else {
      filteredStudents = students
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
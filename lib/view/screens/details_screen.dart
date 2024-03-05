
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/constants/constants.dart';
import 'package:student_app_provider/controller/provider/details_provider.dart';
import 'package:student_app_provider/model/student_model.dart';
import 'package:student_app_provider/view/screens/edit_screen.dart';
import 'package:student_app_provider/view/widgets/delete_dialogue.dart';


class DetailScreen extends StatelessWidget {
  final Student student;
  const DetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _deleteDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(student: student),
                ),
              ).then((_) => Navigator.pop(context));
            },
          ),
        ],
        backgroundColor: appBarColor,
      ),
      body: Column(
        children: [
          kheight20,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(student.profilePic)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kheight20,
                  Text(
                    'Name : ${student.name}',
                    style: textstyle,
                  ),
                  kheight20,
                  Text(
                    'Gaurdian Name : ${student.guardianName}',
                    style: textstyle,
                  ),
                  kheight20,
                  Text(
                    'Place : ${student.place}',
                    style: textstyle,
                  ),
                  kheight20,
                  Text(
                    'Age : ${student.phoneNumber}',
                    style: textstyle,
                  ),
                  kheight20,
                  const SizedBox(
                    width: 63,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _deleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        onCancel: () {
          Navigator.pop(context);
        },
        onDelete: () {
          Provider.of<DetailProvider>(context, listen: false)
              .deleteStudent(student.id);
          void popUntilHomeScreen(BuildContext context) {
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          popUntilHomeScreen(context);
        },
      ),
    );
  }
}
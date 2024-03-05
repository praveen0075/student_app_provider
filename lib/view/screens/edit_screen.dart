import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/constants/constants.dart';
import 'package:student_app_provider/controller/db/db_functions.dart';
import 'package:student_app_provider/controller/provider/edit_provider.dart';
import 'package:student_app_provider/model/student_model.dart';
import 'package:student_app_provider/view/widgets/save_button.dart';

class EditScreen extends StatelessWidget {
  final Student student;
  EditScreen({super.key, required this.student});

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _gaurdianController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final editStudentProvider = Provider.of<EditProvider>(context);

    _nameController.text = student.name;
    _gaurdianController.text = student.guardianName;
    _placeController.text = student.place;
    _phoneController.text = student.phoneNumber.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Students"),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              kheight20,
              GestureDetector(
                onTap: () async {
                  XFile? img = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  editStudentProvider.setImage(img);
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: editStudentProvider.profilePicturePath !=
                          null
                      ? FileImage(File(editStudentProvider.profilePicturePath!))
                      : FileImage(File(student.profilePic)),
                ),
              ),
              kheight20,
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text('Student Name'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Student Name';
                  } else {
                    return null;
                  }
                },
              ),
              kheight20,
              TextFormField(
                controller: _gaurdianController,
                 decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.family_restroom),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text(' School Name'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter The school Name';
                  } else {
                    return null;
                  }
                },
              ),
              kheight20,
              TextFormField(
                controller: _placeController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.place),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text('Father Name'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Father Name';
                  } else {
                    return null;
                  }
                },
              ),
              kheight20,
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: const Text('Age'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Age';
                  } else {
                    return null;
                  }
                },
              ),
              kheight40,
              Savebutton(onTap: () {
                if (_formkey.currentState!.validate()) {
                  final name = _nameController.text;
                  final gname = _gaurdianController.text;
                  final place = _placeController.text;
                  final phone = int.parse(_phoneController.text);

                  final updatedStudent = Student(
                    id: student.id,
                    name: name,
                    guardianName: gname,
                    place: place,
                    phoneNumber: phone,
                    profilePic:
                        editStudentProvider.profilePicturePath ??
                            student.profilePic,
                  );
                  DbHelper.updateStudent(updatedStudent).then((id) {
                    if (id > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Student updated successfully')),
                      );
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to update student')),
                      );
                    }
                  });
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/constants/constants.dart';
import 'package:student_app_provider/controller/db/db_functions.dart';
import 'package:student_app_provider/controller/provider/add_provider.dart';
import 'package:student_app_provider/model/student_model.dart';
import 'package:student_app_provider/view/widgets/save_button.dart';

class AddScreen extends StatelessWidget {
 AddScreen({super.key});
   final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _gaurdianController = TextEditingController();
  final _placeController = TextEditingController();
  final _phoneController = TextEditingController();

  XFile? img;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Add Students",),
        backgroundColor: appBarColor,
      ),
       body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formkey,
          child: Consumer<AddProvider>(
            builder: (context, addStudentProvider, _) {
              return ListView(
                children: [
                  GestureDetector(
                    onTap: () async {
                       img = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      // ignore: use_build_context_synchronously
                      Provider.of<AddProvider>(context, listen: false)
                          .setImage(img);
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          addStudentProvider.profilePicturePath != null
                              ? FileImage(
                                  File(addStudentProvider.profilePicturePath!))
                              : null,
                      child: addStudentProvider.profilePicturePath == null
                          ? const Icon(
                              Icons.add_a_photo,
                              size: 35,
                            )
                          : null,
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
                      label: const Text('Gaurdian Name'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter The gaurdian Name';
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
                      label: const Text('Place'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Place';
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
                      label: const Text('Phone'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Phone number';
                      } else {
                        return null;
                      }
                    },
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  kheight40,
                  Savebutton(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        final student = Student(
                          id: 0,
                          name: _nameController.text,
                          guardianName: _gaurdianController.text,
                          place: _placeController.text,
                          phoneNumber: int.parse(_phoneController.text),
                          profilePic:
                              addStudentProvider.profilePicturePath.toString(),
                        );
                        if(img == null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please add an image"),backgroundColor: Colors.red,));
                        }else{
                          DbHelper.addStudentToDb(student).then((id) {
                          if (id > 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Student added successfully')),
                            );
                             Provider.of<AddProvider>(context, listen: false)
                        .clearImage();
                        _nameController.clear();
                        _gaurdianController.clear();
                        _placeController.clear();
                        _phoneController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Failed to add student')),
                            );
                          }
                        });
                        }
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
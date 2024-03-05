import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/constants/constants.dart';
import 'package:student_app_provider/controller/provider/home_provider.dart';
import 'package:student_app_provider/view/screens/add_screen.dart';
import 'package:student_app_provider/view/screens/details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddScreen())).then((value) => homeProvider.refreshStudentList());
      }),
       appBar: AppBar(
        backgroundColor: appBarColor,
        // title: 
        title: !homeProvider.isSearching
            ? const Text('Student List')
            :
        TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  homeProvider.filterStudents(query);
                },
                decoration: const InputDecoration(
                  hintText: 'Search student here',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              homeProvider.toggleSearch();
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: homeProvider.filteredStudents.isEmpty
          ? const Center(
              child: Text(
                'No students found.',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 4,
                    wordSpacing: 5),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: homeProvider.filteredStudents.length,
              itemBuilder: (context, index) {
                final student = homeProvider.filteredStudents[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(student: student),
                      ),
                    ).then((value) => homeProvider.refreshStudentList());
                  },
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.black,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                            const SizedBox(
                              width: 20,
                            ),

                           CircleAvatar(
                          radius: 30.0,
                          backgroundImage:
                              FileImage(File(student.profilePic)),
                        ),
                        const SizedBox(width: 20,),
                         Text(
                          student.name,
                          style: const TextStyle(
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              overflow: TextOverflow.fade),
                        ),
                        const Spacer(),
                      
                        ],
                      )
                    ),
                  ),
                );
              },
            ),
    );
  }
}
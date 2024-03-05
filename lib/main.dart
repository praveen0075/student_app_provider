import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app_provider/controller/db/db_functions.dart';
import 'package:student_app_provider/controller/provider/add_provider.dart';
import 'package:student_app_provider/controller/provider/details_provider.dart';
import 'package:student_app_provider/controller/provider/edit_provider.dart';
import 'package:student_app_provider/controller/provider/home_provider.dart';
import 'package:student_app_provider/controller/provider/splash_provider.dart';
import 'package:student_app_provider/view/screens/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>SplashProvider()),
        ChangeNotifierProvider(create: (_)=>DetailProvider()),
        ChangeNotifierProvider(create: (_)=>HomeProvider()),
        ChangeNotifierProvider(create: (_)=>AddProvider()),
        ChangeNotifierProvider(create: (_)=>EditProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}


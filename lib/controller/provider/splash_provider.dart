import 'package:flutter/material.dart';
import 'package:student_app_provider/view/screens/home_screen.dart';

class SplashProvider extends ChangeNotifier {
  Future<void> gotoLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 4));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (ctx) => const HomeScreen(),
    ));
  }
}

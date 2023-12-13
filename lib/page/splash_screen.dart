import 'package:appstagram/page/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5)).then(
      (value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      },
    );
    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.cover,
      ),
    ));
  }
}

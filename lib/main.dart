import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/screens/auth/register.dart';
import 'package:flutter_ecommerce/modules/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      home: Register()
    );
  }
}



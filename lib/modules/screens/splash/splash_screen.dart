import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(Routes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Expanded(child: 
              Center(
                child: Image.asset('images/logo.png',height: 200,width: 200,),
              ),
            ),
            const Text('Developed by Hassan Elshazly ',style: TextStyle(color: Colors.grey),),
          ],
        ),
      ),
    );
  }
}
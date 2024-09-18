import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/screens/auth/user_repo.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              UserRepository.logout();
              Get.toNamed(Routes.login);
            },
          ),
        ],
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
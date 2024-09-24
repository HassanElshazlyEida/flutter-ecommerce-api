import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title:  Text('Home'.tr),
      ),
      drawer: const MenuDrawer(),
      body:  Center(
        child: Text('Home Screen'.tr),
      ),
    );
  }
}
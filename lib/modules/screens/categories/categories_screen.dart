import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      drawer: const MenuDrawer(),
      body: const Center(
        child: Text('Categories Screen'),
      ),
    );
  }
}
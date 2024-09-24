import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      drawer: const MenuDrawer(),
      body: const Center(
        child: Text('Cart Screen'),
      ),
    );
  }
}
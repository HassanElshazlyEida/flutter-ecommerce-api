import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      drawer: const MenuDrawer(),
      body: const Center(
        child: Text('Wishlist Screen'),
      ),
    );
  }
}
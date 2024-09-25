import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/shared/style/colors.dart';
import 'package:get/get.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    
    return BlocBuilder<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return Scaffold(
          drawer: const MenuDrawer(),
          appBar: AppBar(
            title: Image.asset('images/logo.png', height: 75, width: 75),
          ),
          body: cubit.screens[cubit.bottomNavIndex],
          backgroundColor: Colors.grey[200],
          bottomNavigationBar:
            BottomNavigationBar(onTap: (value) {
              cubit.changeBottomNavIndex(value);
            },
            currentIndex: cubit.bottomNavIndex, 
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              
              BottomNavigationBarItem(
                  icon: const Icon(Icons.category), label: 'Categories'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite), label: 'Wishlist'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home), label: 'Home'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart), label: 'Cart'.tr),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person), label: 'Profile'.tr),
            ]
            ),
        );
      },
    );
  }
}

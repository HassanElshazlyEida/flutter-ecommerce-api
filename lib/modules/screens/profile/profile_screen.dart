import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/component/menu_drawer.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => LayoutCubit()..userData(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {
         if (state is ErrorUserDataState) {
            Get.toNamed(Routes.home);
            Get.snackbar('Error'.tr, state.message);
         }
        },
        builder: (context, state) {
          if(state is LoadingUserDataState) {
            return const Scaffold(
              body:  Center(child: CircularProgressIndicator())
            );
          }
          final cubit = BlocProvider.of<LayoutCubit>(context); 

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
            ),
          );
        },
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = Get.find<LayoutCubit>();
    
    return  BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is LanguageChangedState) {
          cubit.reloadCategories(); 
        }
      },
      builder: (context, state) {
      return Scaffold(
      body: 
      cubit.categories.isEmpty
        ? const Center(child: CupertinoActivityIndicator(),)
        :
       Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemCount: cubit.categories.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10), // Set the border radius
                        child: Image.network(
                          cubit.categories[index].image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                  ),
                  Text(cubit.categories[index].name!,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              )
            );
          },
        ),
      ));
      });
  }
}
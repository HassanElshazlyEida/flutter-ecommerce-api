import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<LayoutCubit, LayoutStates>(
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
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage('${cubit.userModel?.image}'),
                      backgroundColor: Colors.transparent,
                      
                    )),
                  const SizedBox(height: 16.0,),
                  Text('${cubit.userModel?.name}',style: const TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
                  Padding(
                     padding: const EdgeInsets.only(left:20,top: 20,right: 10),
                      child: Column(children: [
                    const SizedBox(height: 60.0,),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'Name'.tr,
                        labelStyle: const TextStyle(color: Colors.pink),
                      ),
                      initialValue: cubit.userModel?.name,
                      readOnly: true,
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'Email'.tr ,
                        labelStyle:const TextStyle(color: Colors.pink),
                      ),
                      initialValue: cubit.userModel?.email,
                      readOnly: true,
                    ),
                    const SizedBox(height: 16.0,),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: 'Phone'.tr,
                        labelStyle: const TextStyle(color: Colors.pink),
                      ),
                      initialValue: cubit.userModel?.phone,
                      readOnly: true,
                    ),
                        ],
                      )
                  )
                
                  
      
                ],
              ),
            ),
          );
        },
    );
  }
}
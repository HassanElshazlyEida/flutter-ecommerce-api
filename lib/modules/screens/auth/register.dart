import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_states.dart';
import 'package:flutter_ecommerce/modules/screens/home/home_screen.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit,AuthStates>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                content: Text(state.message,style: const  TextStyle(color: Colors.white)),
                backgroundColor: Colors.red,
                actions: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Center(child:  Text('OK')))
                ],
              );
            });
          }else if (state is AuthAuthenticatedState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          }
        },
        builder: (context, state) {
          return  Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sign Up',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 16.0,),
                    _textFieldItem(controller: nameController, label: 'Name', hint : 'Enter your name'),
                    const SizedBox(height: 16.0,),
                    _textFieldItem(controller: emailController, label: 'Email', hint : 'Enter your email'),
                    const SizedBox(height: 16.0,),
                    _textFieldItem(controller: phoneController, label: 'Phone', hint : 'Enter your phone'),
                    const SizedBox(height: 16.0,),
                    _textFieldItem(controller: passwordController, label: 'Password',hint  : 'Enter your password', isPassword: true),
                    const SizedBox(height: 16.0,),
                    MaterialButton(
                      onPressed: (){
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).register(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                          );
                        }
                      },
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      minWidth: double.infinity,
                      color: Colors.blue,
                      child:  Text(state is AuthLoadingState ? "Loading ...": "Register",style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}

Widget _textFieldItem({required TextEditingController controller, required String hint, String? label, bool? isPassword}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please enter your ${label ?? hint}';
      }
      return null;
    },
    obscureText: isPassword ?? false,
    decoration:  InputDecoration(
      border: const OutlineInputBorder(),
      labelText: label,
      hintText: hint,
    ),
  );
}
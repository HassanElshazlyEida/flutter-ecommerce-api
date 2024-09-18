import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Helpers/helpers.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_states.dart';
import 'package:flutter_ecommerce/modules/screens/auth/register.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/shared/style/colors.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          showDialog(
              context: context,
              builder: (context) => Helpers.errorDialog(context: context, message: state.message)
          );
        }else if (state is AuthAuthenticatedState) {
            Get.toNamed(Routes.home);
        }
      },
      builder: (context, state) {
        return BlocBuilder<AuthCubit, AuthStates>(
          builder: (context, state) {
            return Scaffold(
              body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 40),
                        child: null
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Form(
                          key: formKey,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ListView(
                                children: [
                                  Center(
                                      child: Image.asset('images/logo.png',
                                          height: 150, width: 150)),
                                  Helpers.formField(
                                      controller: emailController,
                                      label: 'Email',
                                      hint: 'Enter your email'),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Helpers.formField(
                                      controller: passwordController,
                                      label: 'Password',
                                      hint: 'Enter your password',
                                      isPassword: true),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthCubit>(context)
                                            .login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    minWidth: double.infinity,
                                    color: mainColor,
                                    child: Text(
                                      state is AuthLoadingState
                                          ? "Loading ..."
                                          : "Login",
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                   const SizedBox(height: 15,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [
                                      const Text('Don\'t have an account? ',style: TextStyle(color: Colors.black)),
                                     const  SizedBox(width: 4,),
                                      InkWell(
                                        onTap: ()
                                        {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                                        },
                                        child: const Text('Create one',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ))
                ],
              ),
            ));
          },
        );
      },
    );
  }
}

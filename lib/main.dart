import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecommerce/modules/screens/auth/login.dart';
import 'package:flutter_ecommerce/shared/bloc/global_bloc_observer.dart';
import 'package:flutter_ecommerce/shared/style/colors.dart';

void main() {
  Bloc.observer = GlobalBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child:  MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme:  ThemeData(
          primaryColor: thirdColor
        ),
        home: const Login()
      ),
    );
  }
}



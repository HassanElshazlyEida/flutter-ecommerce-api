import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/shared/bloc/global_bloc_observer.dart';
import 'package:flutter_ecommerce/shared/network/local_network.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = GlobalBlocObserver();

  await CacheNetwork.init();

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
      child:  GetMaterialApp(
        initialRoute: Routes.home,
        getPages: AppPages.pages,
      ),
    );
  }
}



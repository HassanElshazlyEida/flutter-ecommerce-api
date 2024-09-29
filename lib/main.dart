import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_cubit.dart';
import 'package:flutter_ecommerce/locale/locale_controller.dart';
import 'package:flutter_ecommerce/locale/locale_translations.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/shared/bloc/global_bloc_observer.dart';
import 'package:flutter_ecommerce/shared/network/local_network.dart';
import 'package:flutter_ecommerce/themes/theme_controller.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = GlobalBlocObserver();

  await CacheNetwork.init();

  Get.lazyPut<ThemeController>(() => ThemeController());
  Get.lazyPut<LocaleController>(() => LocaleController());
  Get.lazyPut<LayoutCubit>(() => LayoutCubit());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) =>  Get.find<LayoutCubit>()
        ..getBannersData()
        ..getCategoriesData()
        ..getProductsData()
        ..getWishlistData()
        ..userData()
        ..getCartData()
        ),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeController.theme(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[100], 
          ),
          darkTheme: ThemeData.dark(),
          locale: LocaleController.lang(),  
          translations: LocaleTranslations(),
          initialRoute: Routes.home,
          getPages: AppPages.pages,
        )
    );
  }
}



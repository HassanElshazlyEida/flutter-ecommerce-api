import 'package:flutter_ecommerce/middleware/auth_middleware.dart';
import 'package:flutter_ecommerce/modules/screens/auth/login.dart';
import 'package:flutter_ecommerce/modules/screens/auth/register.dart';
import 'package:flutter_ecommerce/modules/screens/home/home_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () =>const  HomeScreen(),
      middlewares: [AuthMiddleware()],
      
    ),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      
    ),
    GetPage(
      name: Routes.register,
      page: () => Register(),
  
    ),
  ];
}
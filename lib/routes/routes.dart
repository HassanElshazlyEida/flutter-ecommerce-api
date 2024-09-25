import 'package:flutter_ecommerce/layout/layout_screen.dart';
import 'package:flutter_ecommerce/middleware/auth_middleware.dart';
import 'package:flutter_ecommerce/modules/screens/auth/login.dart';
import 'package:flutter_ecommerce/modules/screens/auth/register.dart';
import 'package:flutter_ecommerce/modules/screens/profile/profile_screen.dart';
import 'package:get/get.dart';

class Routes {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const profile = '/profile';
  static const categories = '/categories';
  static const wishlist = '/wishlist';
  static const cart = '/cart';
  
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () =>const LayoutScreen(),
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
    // profile page
    GetPage(
      name: Routes.profile,
      page: () =>const  ProfileScreen(),
      middlewares: [AuthMiddleware()],
    ),

  ];
}
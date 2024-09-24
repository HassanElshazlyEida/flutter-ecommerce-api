import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/screens/auth/user_repo.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (!UserRepository.isAuthenticated()) {
       return const RouteSettings(name: Routes.login);
    }
    return null;
  }
}
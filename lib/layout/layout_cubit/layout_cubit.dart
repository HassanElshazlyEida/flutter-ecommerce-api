import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Helpers/helpers.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/banner_model.dart';
import 'package:flutter_ecommerce/models/category_model.dart';
import 'package:flutter_ecommerce/models/user_model.dart';
import 'package:flutter_ecommerce/modules/screens/cart/cart_screen.dart';
import 'package:flutter_ecommerce/modules/screens/categories/categories_screen.dart';
import 'package:flutter_ecommerce/modules/screens/home/home_screen.dart';
import 'package:flutter_ecommerce/modules/screens/profile/profile_screen.dart';
import 'package:flutter_ecommerce/modules/screens/wishlist_screen/wishlist_screen.dart';
import 'package:flutter_ecommerce/shared/network/dio_service.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  final DioService _dio = DioService();

  List<Widget> screens = [const CategoriesScreen(),const WishlistScreen(),const HomeScreen(),const CartScreen() ,const ProfileScreen()];

  int bottomNavIndex = 2;

  UserModel? userModel;
  List<BannerModel> banners = [];
  List<CategoryModel> categories = [];

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  void userData() async {
    emit(LoadingUserDataState());
    try {
      var response = await _dio.get('${Helpers.apiUrl}/profile');
      if (response.data['status'] == true) {
        userModel = UserModel.fromJson(response.data['data']);
        emit(SuccessUserDataState());
      } else {
        emit(ErrorUserDataState(response.data['message']));
      }
    } catch (e) {
      print(e);
      emit(ErrorUserDataState('Unknown error occurred'));
    }
  }

  void getBannersData() async {
    emit(LoadingBannersState());
    try {
      var response = await _dio.get('${Helpers.apiUrl}/banners');
      if (response.data['status'] == true) {
       banners = (response.data['data'] as List).map((e) => BannerModel.fromJson(e)).toList();
        emit(SuccessBannersState());
      } else {
        emit(ErrorBannersState(response.data['message']));
      }
    } catch (e) {
      print(e);
      emit(ErrorBannersState('Unknown error occurred'));
    }
  }

  void getCategoriesData() async {
    emit(LoadingCategoriesState());
    try {
      var response = await _dio.get('${Helpers.apiUrl}/categories');
      if (response.data['status'] == true) {
        categories = (response.data['data']['data'] as List).map((e) => CategoryModel.fromJson(e)).toList();
        emit(SuccessCategoriesState());
      } else {
        emit(ErrorCategoriesState(response.data['message']));
      }
    } catch (e) {
      print(e);
      emit(ErrorCategoriesState('Unknown error occurred'));
    }
  }


}
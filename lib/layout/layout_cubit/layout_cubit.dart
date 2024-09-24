import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Helpers/helpers.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/banner_model.dart';
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

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }

  Future<void> fetchData<T>({
      required String endpoint,
      required Function(dynamic) fromJson,
      required Function(T) onSuccess,
    }) async {
      emit(FetchingDataState());
      try {
        var response = await _dio.get('${Helpers.apiUrl}$endpoint');
        if (response.data['status'] == true) {
          T data = fromJson(response.data['data']);
          onSuccess(data);
          emit(DataLoadedState());
        } else {
          emit(ErrorFetchingDataState(response.data['message']));
        }
      } catch (e) {
        print(e);
        emit(ErrorFetchingDataState('Unknown error occurred'));
      }
  }

  void userData() {
    fetchData<UserModel>(
      endpoint: '/profile',
      fromJson: (data) => UserModel.fromJson(data),
      onSuccess: (data) {
        userModel = data;
      },
    );
   
  }

  void getBannersData() {
    fetchData<List<BannerModel>>(
      endpoint: '/banners',
      fromJson: (data) => (data as List).map((e) => BannerModel.fromJson(e)).toList(),
      onSuccess: (data) {
        banners = data;
      },
    );
  }


}
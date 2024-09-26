import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Helpers/helpers.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/banner_model.dart';
import 'package:flutter_ecommerce/models/category_model.dart';
import 'package:flutter_ecommerce/models/product_model.dart';
import 'package:flutter_ecommerce/models/user_model.dart';
import 'package:flutter_ecommerce/modules/screens/cart/cart_screen.dart';
import 'package:flutter_ecommerce/modules/screens/categories/categories_screen.dart';
import 'package:flutter_ecommerce/modules/screens/home/home_screen.dart';
import 'package:flutter_ecommerce/modules/screens/profile/profile_screen.dart';
import 'package:flutter_ecommerce/modules/screens/wishlist_screen/wishlist_screen.dart';
import 'package:flutter_ecommerce/routes/routes.dart';
import 'package:flutter_ecommerce/shared/network/dio_service.dart';
import 'package:flutter_ecommerce/shared/network/local_network.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  final DioService _dio = DioService();

  List<Widget> screens = [const CategoriesScreen(),const WishlistScreen(),const HomeScreen(),const CartScreen() ,const ProfileScreen()];

  Map<String,int> screenRoutes  = {
    Routes.categories: 0,
    Routes.wishlist:1,
    Routes.home:2,
    Routes.cart: 3,
    Routes.profile: 4,
  };

  int bottomNavIndex = 2;
  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavIndexState());
  }
  
  UserModel? userModel;
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
  
  List<BannerModel> banners = [];
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
  
  List<CategoryModel> categories = [];
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

  List<ProductModel> products = [];
  void getProductsData() async {
    emit(LoadingProductsState());
    try {
      var response = await _dio.get('${Helpers.apiUrl}/home');
      if (response.data['status'] == true) {
        products = (response.data['data']['products'] as List).map((e) => ProductModel.fromJson(e)).toList();
        emit(SuccessProductsState());
      } else {
        emit(ErrorProductsState(response.data['message']));
      }
    } catch (e) {
      print(e);
      emit(ErrorProductsState('Unknown error occurred'));
    }
  }

  List<ProductModel> filteredProducts = [];
  void filterProducts(String text) {
    filteredProducts = products.where((element) => element.name!.contains(text)).toList();
    emit(FilterProductsState());
  }



  void reloadData() {
    _dio.dio.options.headers['lang'] = CacheNetwork.getCache('lang') ?? 'en';
    products = [];
    categories = [];  
    wishlist = [];
    filteredProducts = [];
    filteredWishlist = [];
    userModel = null;
    getCategoriesData();
    getProductsData();
    getWishlistData();
    userData();
  }



  List<ProductModel> wishlist = [];
  void getWishlistData() async {
    emit(LoadingWishlistState());
    try {
      var response = await _dio.get('${Helpers.apiUrl}/favorites');
      if (response.data['status'] == true) {

        wishlist = (response.data['data']['data'] as List).map((e) {
          var productJson = e['product'] as Map<String, dynamic>;
          productJson['in_favorites'] = true;
          return ProductModel.fromJson(productJson);
        }).toList();
        emit(SuccessWishlistState());
      } else {
        emit(ErrorWishlistState(response.data['message']));
      }
    } catch (e) {
      print(e);
      emit(ErrorWishlistState('Unknown error occurred'));
    }
  }
  List<ProductModel> filteredWishlist = [];
  void filterWishlist(String text) {
    
    filteredWishlist = wishlist.where((element) => element.name!.contains(text)).toList();
    emit(FilterWishlistState());
  }

  void changeProductFavorite(int id) async {
    try {
      var response = await _dio.post('${Helpers.apiUrl}/favorites', {
        'product_id': id.toString(),
      });
      if (response.data['status'] == true) {
        getWishlistData();
      } 
    } catch (e) {
      print(e);
    }
  }
}
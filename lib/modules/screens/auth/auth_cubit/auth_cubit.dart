import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Helpers/helpers.dart';
import 'package:flutter_ecommerce/shared/network/dio_service.dart';
import 'package:flutter_ecommerce/shared/network/local_network.dart';
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final DioService _dio = DioService();

  AuthCubit() : super(AuthInitialState());

  void register({required String name, required String email, required String phone, required String password}) async {
    await _authenticate('register', {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
    });
  }

  void login({required String email, required String password}) async {
    await _authenticate('login', {
      'email': email,
      'password': password,
    });
  }
  Future<void> _authenticate(String endpoint, Map<String, String> body) async {
    emit(AuthLoadingState());
    try {
      final response = await _dio.post('${Helpers.apiUrl}/$endpoint',body);

      if (response.data['status'] == true) {
        await CacheNetwork.setCache('token', response.data['data']['token']);
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthErrorState(response.data['message']));
      }
    } catch (e) {
      emit(AuthErrorState('Unknown error occur'));
    }
  }

 
}
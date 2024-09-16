import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Helpers/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ecommerce/modules/screens/auth/auth_cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  void register({required String name,required String email,required String phone , required String password}) async {
    emit(AuthLoadingState());
    try {
      final response = await http.post(
        Uri.parse('${Helpers.apiUrl}/register'),
        body: {
          'email': email,
          'name': name,
          'phone': phone,
          'password': password,
        },
        headers: {
          'lang': 'en',
        }
      );
      var responseBody = jsonDecode(response.body);
      if (responseBody['status'] == true) {
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthErrorState(responseBody['message']));
      }
    } catch (e) {
      emit(AuthErrorState('Unknown error occur'));
    }
  }
}
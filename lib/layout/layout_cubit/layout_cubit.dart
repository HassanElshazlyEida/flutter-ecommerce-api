import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Helpers/helpers.dart';
import 'package:flutter_ecommerce/layout/layout_cubit/layout_states.dart';
import 'package:flutter_ecommerce/models/user_model.dart';
import 'package:flutter_ecommerce/shared/network/dio_service.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());

  final DioService _dio = DioService();
  UserModel? userModel;
  

  void userData () async {
    // TODO : use cache to get user data
    emit(LoadingUserDataState());
    var response = await _dio.get('${Helpers.apiUrl}/profile');
    try {
      print(response.headers);
      if(response.data['status'] == true){
        userModel = UserModel.fromJson(response.data['data']);
        emit(SuccessUserDataState());
      }else{
        emit(ErrorUserDataState(response.data['message']));
      }
     } catch (e) {
      print(e);
      emit(ErrorUserDataState('Unknown error occur'));
    }
  }


}
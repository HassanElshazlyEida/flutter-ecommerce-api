
import 'package:flutter_ecommerce/shared/network/local_network.dart';

class UserRepository {
  static bool isAuthenticated() {
    print('token ${CacheNetwork.getCache('token')}');
    if(CacheNetwork.getCache('token') !=null){
      return true;
    }
    return false;
  }
  // logout
  static void logout() {
    CacheNetwork.removeCache('token');
    
  }
}
import 'package:b1_first_flutter_app/data/enum/login_type.dart';
import 'package:b1_first_flutter_app/data/local/auth_prefs.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  
  set isLoggedIn(bool status){
   _isLoggedIn = status;
    notifyListeners();
  }
  
  Future<bool> login (String username, String password) async{
    if(username != "account1" || password != "123456") return false;
    String token = username;
    
    AuthPrefs.getInstance().saveAuthToken(token, LoginType.STANDARD);
    _isLoggedIn = true;

    notifyListeners();
    return true;
  }

  Future<void> logout() async{
    AuthPrefs.getInstance().removeAuthToken();
    _isLoggedIn = false;
    notifyListeners();
  } 

  Future<void> loadLoginStatus() async{
    LoginType? loginType = await AuthPrefs.getInstance().getLoginType();
    _isLoggedIn = (loginType == null) ? false : true;
    notifyListeners();
  }

  Future<String?> getToken() async {
     return AuthPrefs.getInstance().getAuthToken();
  }

}

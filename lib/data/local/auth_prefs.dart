import 'package:b1_first_flutter_app/data/enum/login_type.dart';
import 'package:b1_first_flutter_app/data/enum/shared_prefs_keys.dart';
import 'package:b1_first_flutter_app/util/platform.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs {
  static AuthPrefs? _instance;
  AuthPrefs._privateConstructor();
  
  static AuthPrefs getInstance() {
    _instance ??= AuthPrefs._privateConstructor();
    return _instance!;
  }

  String? _cachedToken;
  final _keyToken = SharedPrefsKeys.AUTH_TOKEN;
  final _keyLoginType = SharedPrefsKeys.LOGIN_TYPE;
  
  Future<void> saveAuthToken(String authToken, LoginType loginType) async{
    if (!PlatformUtil.isAndroid()&&!PlatformUtil.isIOS()&&!PlatformUtil.isWeb())  return;

    final storage = const FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();

    await storage.write(key: _keyToken.value, value: authToken);
    await prefs.setString(_keyLoginType.value, loginType.name);
    _cachedToken = authToken;
  }

  Future<String?> getAuthToken() async{
    if (!PlatformUtil.isAndroid()&&!PlatformUtil.isIOS()&&!PlatformUtil.isWeb())  return null;
    if (_cachedToken != null) return _cachedToken;

    final storage = const FlutterSecureStorage();
    _cachedToken = await storage.read(key: _keyToken.value); 
    return _cachedToken;
  }


  Future<void> removeAuthToken() async{
    if (!PlatformUtil.isAndroid()&&!PlatformUtil.isIOS()&&!PlatformUtil.isWeb())  return;
    
    final prefs = await SharedPreferences.getInstance();
    final storage = const FlutterSecureStorage();

    await storage.delete(key: _keyToken.value);
    await prefs.remove(_keyLoginType.value);
    _cachedToken = null;
  }


  Future<LoginType?> getLoginType() async{
    if (!PlatformUtil.isAndroid()&&!PlatformUtil.isIOS()&&!PlatformUtil.isWeb())  return null;
    
    final prefs = await SharedPreferences.getInstance();
    final loginType = prefs.getString(_keyLoginType.value);
    if(loginType == null) return null;
    switch(loginType){
      case 'GOOGLE':
        return LoginType.GOOGLE;
      case 'STANDARD':
        return LoginType.STANDARD;
      default:
        return null;
    }
  }
}
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';
class PlatformUtil {
    static bool isWeb(){
    return kIsWeb;
  }
  
  static bool isWindows(){
    return Platform.isWindows;
  }

  static bool isAndroid(){
    return Platform.isAndroid;
  }

  static bool isIOS(){
    return Platform.isIOS;
  }

  bool isLinux(){
    return Platform.isLinux;
  }

  bool isMacOS(){
    return Platform.isMacOS;
  }
} 
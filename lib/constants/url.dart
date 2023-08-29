import 'dart:io' show Platform;


class AppUrl {
  static String baseUrl = Platform.isIOS ? 'http://127.0.0.1:3333/api/v1' : 'http://10.0.2.2:3333/api/v1';
  static String baseUrlSocket = Platform.isIOS ? 'http://127.0.0.1:3333' : 'http://10.0.2.2:3333';
  static String baseUrlImage = Platform.isIOS ? 'http://127.0.0.1:3333/uploads' : 'http://10.0.2.2:3333/uploads';
}


/*class AppUrl {
  static String baseUrl = 'https://api.letsgoeurope.fr/api/v1';
  static String baseUrlSocket = 'https://api.letsgoeurope.fr/';
  static String baseUrlImage = 'https://api.letsgoeurope.fr/uploads';
}*/

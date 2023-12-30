import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:LetsGo/globals.dart' as globals;
import '../config/url.dart';
import '../utils/routers.dart';
import 'package:LetsGo/views/home/home_screen.dart';

import '../views/login/sign_in.dart';

class DatabaseProvider extends ChangeNotifier {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final requestBaseUrl = AppUrl.baseUrl;

  String _token = '';

  String get token => _token;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<void> checkAuthentication(BuildContext context) async {
    await authenticateUser();
  }

  Future<bool> authenticateUser() async {
    final value = await _pref;
    if (value.containsKey('token')) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> getUser() async {
    String url = '$requestBaseUrl/auth/me';
    http.Response req = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await getToken()}'
    });

    if (req.statusCode == 200 || req.statusCode == 201) {
      final data = json.decode(req.body);
      globals.userID = data['id'];
      return data;
    } else {
      return null;
    }
  }

  void logOut(BuildContext context) async {
    final value = await _pref;

    value.clear();

    PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/url.dart';
import '../database/db_provider.dart';
import '../utils/routers.dart';
import '../utils/snack_message.dart';
import '../views/home/home_screen.dart';
import '../views/login/sign_in.dart';

class AuthenticationProvider extends ChangeNotifier {
  ///Base Url
  final requestBaseUrl = AppUrl.baseUrl;

  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  //Getter
  bool get isLoading => _isLoading;

  String get resMessage => _resMessage;

  void registerUser({
    required String email,
    required String password,
    required String fullName,
    BuildContext? context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      if (requestBaseUrl.isEmpty) {
        throw Exception('requestBaseUrl is null or empty');
      }
      String url = '$requestBaseUrl/auth/register';
      final body = {
        'full_name': fullName,
        'email': email,
        'password': password
      };
      http.Response req = await http.post(Uri.parse(url), body: body);
      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = 'Inscription réussie';
        notifyListeners();
        PageNavigator(ctx: context).nextPageOnly(page: const SignIn());
      } else {
        _resMessage = 'Erreur lors de l\'inscription';
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Erreur de connexion';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = e.toString();
      notifyListeners();
      print(':::: $e');
    }
  }

  //Login
  void loginUser({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      String url = '$requestBaseUrl/auth/login';
      final body = {'email': email, 'password': password};
      http.Response req = await http.post(Uri.parse(url), body: body);
      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _isLoading = false;
        _resMessage = 'Connexion réussie !';
        notifyListeners();
        final token = res['token'];
        DatabaseProvider().saveToken(token);
        if (token.isNotEmpty) {
          PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());
        }
      } else {
        final res = json.decode(req.body);
        _resMessage = res['message'];
        showMessage(
            message: 'vous avez entré un email ou mot de passe incorrect',
            context: context);
        _isLoading = false;

        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Erreur de connexion';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Une erreur est survenue';
      notifyListeners();
    }
  }

  void forgotPassword({
    required String email,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();
      String url = '$requestBaseUrl/auth/forgotPassword';
      final body = {'email': email};
      http.Response req = await http.post(Uri.parse(url), body: body);
      if (req.statusCode == 200 || req.statusCode == 201) {
        final res = json.decode(req.body);
        _resMessage = 'Un lien de réinitialisation de mot de passe a été envoyé à votre adresse email';
        notifyListeners();
      } else {
        final res = json.decode(req.body);
        _resMessage = 'email introuvable';
        _isLoading = false;
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _resMessage = 'Erreur de connexion';
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _resMessage = 'Une erreur est survenue';
    }
  }


  void clear() {
    _resMessage = '';
    _isLoading = false;
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:LetsGo/provider/auth_provider.dart';
import 'package:LetsGo/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'config/url.dart';
import 'database/db_provider.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*Stripe.publishableKey =
      'pk_test_51MdvGWEkovoeS1CWWQk30YnyudXkuXtJ4l1n3CKDmDAn1E5hG66vzrQQR9vqBssaEook290zHYOLAFTydDzm8ODw00UO7ivtC8';*/

  Stripe.publishableKey =
      'pk_live_51MdvGWEkovoeS1CWUCORErQT2jSzP99IG1psfPDIZq7KwAKefiDztQuUsaa3fYDz5TiKO7v5VtSbfAQTDZ36MIxF00gngPuV0x';
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getReservationList();
    super.initState();
  }

  getReservationList() async {
    String url =
        '${AppUrl.baseUrl}/reservations/reservationId/${globals.userID}';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    globals.nbReservation = body.length;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

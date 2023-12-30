import 'dart:convert';

import 'package:LetsGo/services/local_notification_service.dart';
import 'package:LetsGo/views/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:LetsGo/provider/auth_provider.dart';
import 'package:LetsGo/views/splash/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:plausible_analytics/plausible_analytics.dart';

import 'constants/url.dart';
import 'database/db_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:LetsGo/globals.dart' as globals;
import 'package:http/http.dart' as http;

IO.Socket socket = IO.io(AppUrl.baseUrlSocket,
    IO.OptionBuilder().setTransports(['websocket']).build());

String analyticsUrl = 'https://plausible.io';
const String analyticsName = 'letsgoeurope.fr';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51MdvGWEkovoeS1CWWQk30YnyudXkuXtJ4l1n3CKDmDAn1E5hG66vzrQQR9vqBssaEook290zHYOLAFTydDzm8ODw00UO7ivtC8';
  await Stripe.instance.applySettings();
  socket.onConnect((_) {
    print('connect');
  });
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));

  Plausible plausible = Plausible(analyticsUrl, analyticsName);
  // Send goal
  plausible.event(name: 'Device', props: {
    'app_version': 'v1.0.0',
    'app_platform': 'mobile',
    'app_locale': 'fr-FR',
  });

  plausible.event(name: "settings_page");

  plausible.event();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //late final LocalNotificationService service;

  dynamic _user;

  @override
  void initState() {
    socket.on(
        'send notification all users',
        (data) => {
              globals.socketData = data,
              print('send notification all users: $data'),
              if (data != null)
                {
                  /*service.showNotificationWithPayload(
                    id: 0,
                    title: 'LetsGo',
                    body: 'Vous avez un nouveau message',
                    payload: 'payload navigation',
                  )*/
                }
            });
    //service = LocalNotificationService();
    //service.intialize();
    //listenToNotification();
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

/* void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);*/

/*void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    }
  }*/
}

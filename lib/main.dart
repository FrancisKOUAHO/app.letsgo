import 'dart:convert';

import 'package:LetsGo/services/local_notification_service.dart';
import 'package:LetsGo/views/search/search_screen.dart';
import 'package:LetsGo/widgets/notification_badge.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:LetsGo/provider/auth_provider.dart';
import 'package:LetsGo/views/splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'constants/url.dart';
import 'database/db_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:LetsGo/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'models/reservation.model.dart';

IO.Socket socket = IO.io(AppUrl.baseUrlSocket,
    IO.OptionBuilder().setTransports(['websocket']).build());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51MdvGWEkovoeS1CWWQk30YnyudXkuXtJ4l1n3CKDmDAn1E5hG66vzrQQR9vqBssaEook290zHYOLAFTydDzm8ODw00UO7ivtC8';
  await Stripe.instance.applySettings();
  socket.onConnect((_) {
    print('connect');
  }); // this is the event that will be triggered when the server emits the event
  socket.onDisconnect((_) => print('disconnect'));
  socket.on('fromServer', (_) => print(_));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late final LocalNotificationService service;

  @override
  void initState() {
    socket.on(
        'send notification all users',
        (data) => {
              globals.socketData = data,
              print('send notification all users: $data'),
              if (data != null)
                {
                  service.showNotificationWithPayload(
                    id: 0,
                    title: 'LetsGo',
                    body: 'Vous avez un nouveau message',
                    payload: 'payload navigation',
                  )
                }
            });
    service = LocalNotificationService();
    service.intialize();
    saveUserFirebase();
    listenToNotification();
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    _firebaseMessaging.getToken().then((token) {
      print('FirebaseMessaging token: $token');
      assert(token != null);
      print('FCM token : $token');

      _firebaseMessaging.subscribeToTopic('all');
    });

    _firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        int totalNotifications = int.parse(message.data['total_notifications']);
        setState(() {
          NotificationBadge(
              totalNotifications: totalNotifications,
              icon: Icons.notifications);
        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("J'ai reçu un message alors que j'étais au premier plan !");
      print('Message data: ${message.data}');

      globals.dataNotification.addAll([message.data]);

      if (message.notification != null) {
        print(
            'Le message contenait également une notification: ${message.notification}');
        int totalNotifications = int.parse(message.data['total_notifications']);
        setState(() {
          NotificationBadge(
              totalNotifications: totalNotifications,
              icon: Icons.notifications);
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Un nouvel événement onMessageOpenedApp a été publié !');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Le message contenait également une notification: ${message.notification}');
        int totalNotifications = int.parse(message.data['total_notifications']);
        setState(() {
          NotificationBadge(
              totalNotifications: totalNotifications,
              icon: Icons.notifications);
        });
      }
    });
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

  void saveUserFirebase() async {
    String url = '${AppUrl.baseUrl}/auth/getAllUser';

    final response = await http.get(Uri.parse(url));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse.length > 0) {
      jsonResponse.forEach((item) {
        _firestore.collection('users').doc(item['id']).set(item);
      });
    }
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    }
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/globals.dart' as globals;
import 'package:LetsGo/widgets/notification_badge.dart';

import '../../config/url.dart';
import '../../database/db_provider.dart';
import '../../theme/LetsGo_theme.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _totalNotifications = 0;
  final requestBaseUrl = AppUrl.baseUrl;
  final DatabaseProvider db = DatabaseProvider();
  late Position currentposition;
  dynamic _user;

  @override
  void initState() {
    super.initState();
    _totalNotifications = globals.dataNotification.length;
    db.getUser().then((value) {
      setState(() {
        _user = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 100,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: _determinePosition,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(14.0)),
              child: Container(
                color: LetsGoTheme.lightPurple,
                padding: const EdgeInsets.fromLTRB(0, 0, 18, 0),
                height: MediaQuery.of(context).size.height * 0.055,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _determinePosition,
                      icon: Icon(Icons.location_on,
                          color: LetsGoTheme.black,
                          size: MediaQuery.of(context).size.height * 0.025),
                    ),
                    Text(
                      globals.currentAddress ??
                          '${globals.currentAddress.substring(0, 10)}...',
                      style: TextStyle(
                        fontSize: 16,
                        color: LetsGoTheme.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          // Your widgets here
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NotificationBadge(
                icon: Icons.notifications,
                totalNotifications: _totalNotifications),
          ],
        )
      ],
    );
  }

  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
          msg: 'Veuillez activer votre service de localisation');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: 'Les autorisations de localisation sont refusées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              "Les autorisations de localisation sont refusées de manière permanente, nous ne pouvons pas demander d'autorisations.");
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      await placemarkFromCoordinates(position.latitude, position.longitude);

      globals.latitude = position.latitude;
      globals.longitude = position.longitude;

      String url = '$requestBaseUrl/auth/localize';

      final response = await http.post(Uri.parse(url), body: {
        'latitude': '${position.latitude}',
        'longitude': '${position.longitude}',
        'userId': globals.userID,
      });

      setState(() {
        currentposition = position;
        globals.currentAddress = jsonDecode(response.body)['localisation'];
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

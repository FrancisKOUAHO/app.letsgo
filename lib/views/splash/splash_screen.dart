import 'dart:async';

import 'package:flutter/material.dart';

import '../../utils/routers.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      PageNavigator(ctx: context).nextPageOnly(page: const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffedf3fa),
        body: Stack(
          children: <Widget>[
            Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                width: 100,
                height: 100,
                child: Image.asset('assets/logo/LetsGo.png',
                    width: 100, height: 100),
              ),
            ),
            const Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'LetsGo v1.0.6',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 15,
                      color: Color(0xFF302E76)),
                ),
              ),
            ),
          ],
        ));
  }
}

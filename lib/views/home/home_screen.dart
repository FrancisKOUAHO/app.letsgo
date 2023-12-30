import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:LetsGo/views/home/home.dart';
import '../../theme/LetsGo_theme.dart';
import '../booking/list_booking.dart';
import '../favorite/favorite_screen.dart';
import '../profil/profil_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ListBooking(),
    const ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: customAnimatedButtomBar(context),
        extendBody: true);
  }

  Container customAnimatedButtomBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
          colors: [
            const Color(0xFF302E76).withOpacity(0.98),
            const Color(0xFF5B7CB8),
          ],
          stops: const [0.0, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: LetsGoTheme.main,
            iconSize: 28,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.white,
            tabs: const [
              GButton(
                icon: Icons.explore_outlined,
              ),
              GButton(
                icon: Icons.search_outlined,
              ),
              GButton(icon: Icons.favorite_border_outlined),
              GButton(
                icon: Icons.calendar_today_outlined,
              ),
              GButton(icon: Icons.person_outline_outlined)
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

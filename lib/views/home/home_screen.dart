import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:LetsGo/views/home/home.dart';
import 'package:line_icons/line_icons.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 28,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.white,
            tabs: const [
              GButton(
                icon: LineIcons.home,
              ),
              GButton(
                icon: LineIcons.search,
              ),
              GButton(
                icon: LineIcons.heart,
              ),
              GButton(
                icon: LineIcons.alternateTicket,
              ),
              GButton(
                icon: Icons.supervisor_account_outlined,
              )
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

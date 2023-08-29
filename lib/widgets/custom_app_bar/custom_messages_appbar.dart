import 'package:flutter/material.dart';

import '../../theme/LetsGo_theme.dart';
import '../../views/profil/profil_screen.dart';

class CustomMessagesAppBar extends StatefulWidget {
  const CustomMessagesAppBar({Key? key}) : super(key: key);

  @override
  State<CustomMessagesAppBar> createState() => _CustomMessagesAppBarState();
}

class _CustomMessagesAppBarState extends State<CustomMessagesAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 100,
      centerTitle: true,
      title:  Text(
        'Messages',
        style: TextStyle(color: LetsGoTheme.black),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 20, 0),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilScreen()),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://i.pinimg.com/736x/0b/a7/5c/0ba75c6cdd0ee3ea2c9cc4dd0d88be82.jpg',
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

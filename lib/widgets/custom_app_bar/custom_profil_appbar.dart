import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../database/db_provider.dart';
import '../../theme/LetsGo_theme.dart';
import '../../views/profil/settings_scren.dart';

class CustomProfilAppBar extends StatefulWidget {
  const CustomProfilAppBar({Key? key}) : super(key: key);

  @override
  State<CustomProfilAppBar> createState() => _CustomProfilAppBarState();
}

class _CustomProfilAppBarState extends State<CustomProfilAppBar> {

  final DatabaseProvider? db = DatabaseProvider();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 100,
      title:  Text(
        'Mon profil',
        style: TextStyle(color: LetsGoTheme.black),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 27, 0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: const Color(0x3A000000),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Container(
                  color: LetsGoTheme.lightPurple,
                  width: 45,
                  height: 45,
                  child: IconButton(
                    icon:  FaIcon(
                      FontAwesomeIcons.gear,
                      color: LetsGoTheme.main,
                    ),
                    iconSize: 20.0,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScren()),
                      );
                    },
                  ),
                )
              ),
            ),
          ],
        ),
      ],
      centerTitle: true,
    );
  }
}

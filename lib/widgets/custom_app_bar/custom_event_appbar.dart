import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/LetsGo_theme.dart';

class CustomEventAppBar extends StatefulWidget {
  const CustomEventAppBar({Key? key}) : super(key: key);

  @override
  State<CustomEventAppBar> createState() => _CustomEventAppBarState();
}

class _CustomEventAppBarState extends State<CustomEventAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 100,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: LetsGoTheme.main,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Container(
                decoration: BoxDecoration(
                  // color: LetsGoTheme.lightPurple,
                  gradient: LinearGradient(colors: [
                    const Color.fromARGB(255, 225, 225, 225).withOpacity(0.5),
                    const Color.fromARGB(255, 225, 225, 225).withOpacity(0.5),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                width: 45,
                height: 45,
                child: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    color: LetsGoTheme.white,
                  ),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ),
        ],
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
                color: LetsGoTheme.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color.fromARGB(255, 225, 225, 225).withOpacity(0.5),
                      const Color.fromARGB(255, 225, 225, 225).withOpacity(0.5),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  width: 45,
                  height: 45,
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.heart,
                      color: LetsGoTheme.white,
                    ),
                    iconSize: 20.0,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      centerTitle: true,
    );
  }
}

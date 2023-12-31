import 'package:LetsGo/views/home/home.dart';
import 'package:LetsGo/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/LetsGo_theme.dart';

class CustomReturnAppBar extends StatefulWidget {
  final String pageTitle;
  final Color backgroundColor;
  final Color textColor;
  final pushRoute;

  const CustomReturnAppBar(this.pageTitle, this.backgroundColor, this.textColor,
      {Key? key, this.pushRoute})
      : super(key: key);

  @override
  State<CustomReturnAppBar> createState() => _CustomReturnAppBarState();
}

class _CustomReturnAppBarState extends State<CustomReturnAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      elevation: 0,
      leadingWidth: 100,
      centerTitle: true,
      title: Text(
        widget.pageTitle,
        style: TextStyle(
          color: widget.textColor,
        ),
      ),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                  icon: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    color: LetsGoTheme.main,
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
    );
  }
}

import 'package:flutter/material.dart';

class CustomWhitoutAppBar extends StatefulWidget {
  final String pageTitle;
  final Color backgroundColor;
  final Color textColor;
  final pushRoute;

  const CustomWhitoutAppBar(
      this.pageTitle, this.backgroundColor, this.textColor,
      {Key? key, this.pushRoute})
      : super(key: key);

  @override
  State<CustomWhitoutAppBar> createState() => _CustomWhitoutAppBarState();
}

class _CustomWhitoutAppBarState extends State<CustomWhitoutAppBar> {
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
    );
  }
}

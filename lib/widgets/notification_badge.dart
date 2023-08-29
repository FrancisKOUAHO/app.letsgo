import 'package:flutter/material.dart';
import 'package:icon_badge/icon_badge.dart';
import 'package:page_transition/page_transition.dart';
import 'package:LetsGo/globals.dart' as globals;


import '../theme/LetsGo_theme.dart';
import '../views/notifications/notifications.dart';

class NotificationBadge extends StatefulWidget {
  final IconData? icon;

  const NotificationBadge({Key? key,
    required this.icon, required int totalNotifications,
  }) : super(key: key);

  @override
  _NotificationBadgeState createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  late int _totalNotifications;

  void _updateNotificationCount(int count) {
    setState(() {
      _totalNotifications = count;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateNotificationCount(globals.dataNotification.length);
  }

  @override
  Widget build(BuildContext context) {
    return IconBadge(
      icon: Icon(
        widget.icon,
        color: LetsGoTheme.black,
        size: 30,
      ),
      itemCount: _totalNotifications,
      badgeColor: Colors.red,
      itemColor: Colors.white,
      top: 5,
      hideZero: true,
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.leftToRightWithFade,
                child: const Notifications()));
      },
    );
  }
}

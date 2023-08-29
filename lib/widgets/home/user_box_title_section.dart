import 'package:flutter/material.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:skeletons/skeletons.dart';

import '../../database/db_provider.dart';

class UserBoxTitleSection extends StatefulWidget {
  const UserBoxTitleSection({Key? key}) : super(key: key);

  @override
  State<UserBoxTitleSection> createState() => _UserBoxTitleSectionState();
}

class _UserBoxTitleSectionState extends State<UserBoxTitleSection> {
  final DatabaseProvider? db = DatabaseProvider();

  dynamic _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: db!.getUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _user = snapshot.data;
          return Container(
            padding: const EdgeInsets.only(left: 16, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Let's GO ${_user['full_name']}!",
                  style: LetsGoTheme.Title,
                ),
              ],
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 40,
              ),
            ),
          );
        }
      },
    );
  }
}

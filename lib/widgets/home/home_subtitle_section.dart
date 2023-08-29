import 'package:flutter/material.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';

class HomeSubTitleSection extends StatefulWidget {
  const HomeSubTitleSection({Key? key}) : super(key: key);

  @override
  _HomeSubTitleSectionState createState() => _HomeSubTitleSectionState();
}

class _HomeSubTitleSectionState extends State<HomeSubTitleSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child:  Text(
        'Les activités',
        style: LetsGoTheme.Title,
      ),
    );
  }
}

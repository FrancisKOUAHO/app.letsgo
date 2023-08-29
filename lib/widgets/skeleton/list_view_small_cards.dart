import 'package:flutter/cupertino.dart';
import 'package:skeletons/skeletons.dart';

class ListViewSmallCards extends StatefulWidget {
  const ListViewSmallCards({Key? key}) : super(key: key);

  @override
  State<ListViewSmallCards> createState() => _ListViewSmallCardsState();
}

class _ListViewSmallCardsState extends State<ListViewSmallCards> {
  @override
  Widget build(BuildContext context) {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
          borderRadius: BorderRadius.circular(8), height: 200, width: 400),
    );
  }
}

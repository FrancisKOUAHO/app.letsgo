import 'package:flutter/cupertino.dart';
import 'package:skeletons/skeletons.dart';

class ListTitle extends StatefulWidget {
  const ListTitle({Key? key}) : super(key: key);

  @override
  State<ListTitle> createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> {
  @override
  Widget build(BuildContext context) {
    return SkeletonListTile(
      hasSubtitle: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      leadingStyle: const SkeletonAvatarStyle(
          shape: BoxShape.circle, width: 64, height: 64),
      titleStyle: SkeletonLineStyle(borderRadius: BorderRadius.circular(16)),
      subtitleStyle: SkeletonLineStyle(
          borderRadius: BorderRadius.circular(16),
          randomLength: true,
          maxLength: 128),
      verticalSpacing: 16,
    );
  }
}

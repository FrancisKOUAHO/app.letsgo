import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListViewCards extends StatefulWidget {
  const ListViewCards({Key? key}) : super(key: key);

  @override
  State<ListViewCards> createState() => _ListViewCardsState();
}

class _ListViewCardsState extends State<ListViewCards> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: SkeletonItem(
            child: Column(
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: double.infinity,
                minHeight: MediaQuery.of(context).size.height / 8,
                maxHeight: MediaQuery.of(context).size.height / 3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 20, height: 20)),
                    SizedBox(width: 8),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 20, height: 20)),
                    SizedBox(width: 8),
                    SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 20, height: 20)),
                  ],
                ),
                SkeletonLine(
                  style: SkeletonLineStyle(
                      height: 16,
                      width: 64,
                      borderRadius: BorderRadius.circular(8)),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}

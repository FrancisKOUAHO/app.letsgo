import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class VideoDetail extends StatefulWidget {
  const VideoDetail({Key? key}) : super(key: key);

  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('@username',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ExpandableText(
          'lorem upeee dddddddddddd',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          expandText: 'more',
          collapseText: 'less',
          maxLines: 2,
        ),
      ],
    );
  }
}

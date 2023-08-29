import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../widgets/media_player.dart';
import '../../widgets/post_content.dart';


class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map> tiktokItems = [
      {
        'video': 'assets/videos/video_1.mp4',
      },
      {
        'video': 'assets/videos/video_2.mp4',
      },
      {
        'video': 'assets/videos/video_3.mp4',
      },
      {
        'video': 'assets/videos/video_4.mp4',
      },
      {
        'video': 'assets/videos/video_5.mp4',
      },
      {
        'video': 'assets/videos/video_6.mp4',
      },
    ];

    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          height: MediaQuery.of(context).size.height * 0.9,
          scrollDirection: Axis.vertical,
          viewportFraction: 1.0,
        ),
        items: tiktokItems.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                color: const Color(0xFF302E76).withOpacity(0.98),
                child: Stack(
                  children: [
                    MediaPlayer(
                      videoUrl: item['video'],
                    ),
                    const PostContent(),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

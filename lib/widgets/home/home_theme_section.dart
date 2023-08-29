import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/widgets/skeleton/list_view_small_cards.dart';

import '../../common/liste_categories.dart';
import '../../constants/url.dart';
import '../../models/activity.model.dart';
import '../../theme/LetsGo_theme.dart';
import '../../views/event/event_screen.dart';
import '../loader/loader.dart';

class HomeThemeSection extends StatefulWidget {
  const HomeThemeSection({Key? key}) : super(key: key);

  @override
  State<HomeThemeSection> createState() => _HomeThemeSectionState();
}

class _HomeThemeSectionState extends State<HomeThemeSection> {
  Future<List<Activity>> activitiesFuture = getActivityList();

  bool liked = false;

  static Future<List<Activity>> getActivityList() async {
    String url = '${AppUrl.baseUrl}/activities/get_activities/best';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<Activity>(Activity.fromJson).toList();
  }

  Widget buildActivities(List<Activity> activities) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 20),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(),
          child: ListView.builder(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EventScreen(activity: activity)));
                  },
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: Container(
                      width: 185,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 240, 240, 240),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: activity.image!,
                                    width: double.infinity,
                                    height: 66,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const Loader(),
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                            '${Uri.parse(AppUrl.baseUrlImage)}/${activity.image!}'),
                                  )),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    5, 5, 5, 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              liked = !liked;
                                            });
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: !liked
                                                ? Icon(
                                                    Icons.favorite_border,
                                                    color: LetsGoTheme.main,
                                                    size: 22,
                                                  )
                                                : Icon(
                                                    Icons.favorite_outlined,
                                                    color: LetsGoTheme.main,
                                                    size: 22,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 12, 8, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 7, 0),
                                      child: FaIcon(
                                        FontAwesomeIcons.martiniGlassCitrus,
                                        color: Color(0xBA777777),
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      getCategorieId(activity.categoryId)
                                          .toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF57636C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 8, 0, 0),
                                    child: ExpandableText(
                                      activity.name!,
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      expandText: '',
                                      maxLines: 2,
                                      linkColor: Colors.black,
                                    )),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 13, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${activity.price}€',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: LetsGoTheme.main,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Activity>>(
      future: activitiesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: ListViewSmallCards(),
          );
        } else if (snapshot.hasData) {
          final activities = snapshot.data!;
          return buildActivities(activities);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    );
  }
}

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/models/activity.model.dart';
import 'package:LetsGo/widgets/skeleton/list_view_cards.dart';

import '../../config/url.dart';
import '../../theme/LetsGo_theme.dart';
import '../../views/event/event_screen.dart';
import '../loader/loader.dart';

class HomeSliderSection extends StatefulWidget {
  const HomeSliderSection({Key? key}) : super(key: key);

  @override
  _HomeSliderSectionState createState() => _HomeSliderSectionState();
}

class _HomeSliderSectionState extends State<HomeSliderSection> {
  Future<List<Activity>> activitiesFuture = getActivityList();
  bool liked = false;

  static Future<List<Activity>> getActivityList() async {
    String url = '${AppUrl.baseUrl}/activities/get_activities/popular';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<Activity>(Activity.fromJson).toList();
  }

  Widget buildActivities(List<Activity> activities) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 20),
        child: Container(
          width: double.infinity,
          height: 360,
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
                      width: 250,
                      decoration: BoxDecoration(
                        color: LetsGoTheme.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: activity.image!,
                                  width: double.infinity,
                                  height: 360,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Loader(),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                          '${Uri.parse(AppUrl.baseUrlImage)}/${activity.image!}'),
                                ),
                              ),
                              Container(
                                width: 250,
                                height: 360,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: FractionalOffset.bottomCenter,
                                    end: FractionalOffset.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.9),
                                      Colors.transparent,
                                    ],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 130,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: const Color(0x84000000),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Non partenaire',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    132, 34, 34, 34),
                                                shape: BoxShape.circle,
                                              ),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  /* setState(() {
                                                    liked = !liked;
                                                  });
                                                  String url =
                                                      '$requestBaseUrl/favorites/create_favorite';
                                                  final body = {
                                                    'user_id': globals.userID,
                                                    'is_liked': !liked
                                                  };
                                                  http.Response req = await http
                                                      .post(Uri.parse(url),
                                                          body: body);

                                                  if (req.statusCode == 200) {
                                                    showMessage(
                                                        context: context,
                                                        message:
                                                            'Vous avez ajouté cet événement à vos favoris');
                                                  }*/
                                                },
                                                child: !liked
                                                    ? Icon(
                                                        Icons.favorite_border,
                                                        color:
                                                            LetsGoTheme.white,
                                                        size: 24,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_outlined,
                                                        color:
                                                            LetsGoTheme.white,
                                                        size: 24,
                                                      ),
                                              )),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 0, 10),
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    132,
                                                                    34,
                                                                    34,
                                                                    34),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .accessibility_new_outlined,
                                                            color: LetsGoTheme
                                                                .white,
                                                            size: 24,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 0, 5),
                                                        child: ExpandableText(
                                                          activity.name!,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Colors.white,
                                                            fontSize: 19,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          expandText: '',
                                                          maxLines: 2,
                                                          linkColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                0, 0, 0, 10),
                                                        child: ExpandableText(
                                                          activity.description !=
                                                                  null
                                                              ? activity
                                                                  .description!
                                                              : '',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Outfit',
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                          expandText: '',
                                                          maxLines: 2,
                                                          linkColor:
                                                              Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Text(
                                                  'À partir de ',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                                Text(
                                                  '${activity.price} €',
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
          return const ListViewCards();
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

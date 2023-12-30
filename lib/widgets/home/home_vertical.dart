import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/models/activity.model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/liste_categories.dart';
import '../../config/url.dart';
import '../../theme/LetsGo_theme.dart';
import '../../views/event/event_screen.dart';
import '../loader/loader.dart';

class HomeVertical extends StatefulWidget {
  const HomeVertical({Key? key}) : super(key: key);

  @override
  _HomeVerticalState createState() => _HomeVerticalState();
}

class _HomeVerticalState extends State<HomeVertical> {
  late ScrollController _scrollController;
  final List<Activity> activitiesFuture = [];
  final int nbActivitiesLoaded = 30;
  int page = 1;
  bool liked = true;
  bool isLoading = false;
  bool hasMore = true;

  getActivityList() async {
    setState(() {
      isLoading = true;
    });
    String url =
        '${AppUrl.baseUrl}/activities/activities?_limit=$nbActivitiesLoaded&_page=$page';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (var activity in jsonResponse['data']) {
        activitiesFuture.add(Activity.fromJson(activity));
      }
      setState(() {
        isLoading = false;
        page = page + 1;
        hasMore = activitiesFuture.length < nbActivitiesLoaded;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    getActivityList();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    print('_scrollController.offset ${_scrollController.offset}');
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent * 0.95 &&
        !isLoading) {
      print('load more');
      if (hasMore) {
        print('load more');
        getActivityList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 20),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          controller: _scrollController,
          primary: false,
          shrinkWrap: true,
          itemCount: activitiesFuture.length + (hasMore ? 1 : 0),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            if (index == activitiesFuture.length) {
              return SizedBox(
                height: 100,
                width: 50,
                child: LoadingAnimationWidget.halfTriangleDot(
                  size: 50,
                  color: const Color(0xFF302E76),
                ),
              );
            }
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventScreen(activity: activitiesFuture[index])));
              },
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 20, 0),
                child: Container(
                  width: 300,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                              imageUrl: activitiesFuture[index].image!,
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              const Loader(),
                              errorWidget: (context, url, error) =>
                                  Image.network(
                                      '${Uri.parse(AppUrl.baseUrlImage)}/${activitiesFuture[index].image!}'),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                7, 7, 7, 7),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 160,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        color: Color(0x84000000),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(5),
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(10, 0, 10, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: FaIcon(
                                                FontAwesomeIcons
                                                    .martiniGlassCitrus,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              getCategorieId(
                                                      activitiesFuture[index]
                                                          .categoryId)
                                                  .toString(),
                                              style: const TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              liked = !liked;
                                            });
                                          },
                                          child: !liked
                                              ? Icon(
                                                  Icons.favorite_border,
                                                  color: LetsGoTheme.main,
                                                  size: 24,
                                                )
                                              : Icon(
                                                  Icons.favorite_outlined,
                                                  color: LetsGoTheme.main,
                                                  size: 24,
                                                ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 7),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 0, 5),
                                            child: ExpandableText(
                                              activitiesFuture[index].name!,
                                              style: const TextStyle(
                                                fontFamily: 'Outfit',
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              expandText: '',
                                              maxLines: 2,
                                              linkColor: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                    child: ExpandableText(
                                      activitiesFuture[index].description !=
                                              null
                                          ? activitiesFuture[index].description!
                                          : 'Aucune description',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                      expandText: 'Voir plus',
                                      collapseText: 'Voir moins',
                                      maxLines: 3,
                                      linkColor: const Color(0xff4376FF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.07,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'À partir de',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xBA777777),
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          '${activitiesFuture[index].price} €',
                                          style: TextStyle(
                                            color: LetsGoTheme.main,
                                            fontFamily: 'Poppins',
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
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
          },
        ),
      ),
    );
  }
}

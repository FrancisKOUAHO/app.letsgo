import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import '../../config/url.dart';
import '../../models/activity.model.dart';
import '../../theme/LetsGo_theme.dart';
import '../../widgets/custom_app_bar/custom_app_bar.dart';
import '../../widgets/skeleton/list_title.dart';
import '../event/event_screen.dart';
import '../filter/filter_screen.dart';

class Research extends StatefulWidget {
  const Research({Key? key}) : super(key: key);

  @override
  State<Research> createState() => _ResearchState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _ResearchState extends State<Research> {
  final requestBaseUrl = AppUrl.baseUrl;

  final _debouncer = Debouncer();
  List<Activity> _activities = [];
  List<Activity> _searchedActivities = [];

  Future<List<Activity>> getActivityList() async {
    try {
      String url = '${AppUrl.baseUrl}/activities/flutterSearch';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Activity> _activities = parseAgents(response.body);
        return _activities;
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Activity> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Activity>((json) => Activity.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    getActivityList().then((subjectFromServer) {
      setState(() {
        _activities = subjectFromServer;
        _searchedActivities = _activities;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: CustomAppBar(),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                textInputAction: TextInputAction.search,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                onChanged: (string) {
                                  _debouncer.run(() {
                                    setState(() {
                                      _searchedActivities = _activities
                                          .where(
                                            (u) => (u.name!
                                                .toLowerCase()
                                                .contains(
                                                    string.toLowerCase())),
                                          )
                                          .toList();
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                  fillColor: LetsGoTheme.lightPurple,
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  prefixIcon: IconButton(
                                    color: Colors.black,
                                    icon: const Icon(Icons.arrow_back),
                                    iconSize: 20.0,
                                    onPressed: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  suffixIcon: IconButton(
                                    color: Colors.black,
                                    icon: const Icon(Icons.search),
                                    iconSize: 20.0,
                                    onPressed: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  hintText: 'Rechercher des activités...',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FilterScreen()),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: LetsGoTheme.lightPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.menu_outlined,
                          color: LetsGoTheme.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                child: const Text('Des thèmes pour vous inspirez',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 10.0),
              FutureBuilder(
                future: getActivityList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        children: const [
                          ListTitle(),
                          SizedBox(height: 10),
                          ListTitle(),
                          SizedBox(height: 10),
                          ListTitle(),
                          SizedBox(height: 10),
                          ListTitle(),
                          SizedBox(height: 10),
                          ListTitle(),
                          SizedBox(height: 10),
                          ListTitle(),
                          SizedBox(height: 10),
                          ListTitle()
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _searchedActivities.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, index) {
                        final activity = _searchedActivities[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15, 15, 15, 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: CachedNetworkImage(
                                        imageUrl: activity.image!,
                                        width: 66,
                                        height: 66,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Image.network(
                                                '${Uri.parse(AppUrl.baseUrlImage)}/${activity.image}'),
                                      )),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              17, 0, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/icons/Category.png',
                                                width: 17,
                                                height: 17,
                                                fit: BoxFit.cover,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(7, 0, 0, 0),
                                                child: Wrap(
                                                  children: [
                                                    SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        activity.name!,
                                                        style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 30, 0, 0),
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      elevation: 0,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EventScreen(
                                                            activity:
                                                                activity)));
                                          },
                                          child: SvgPicture.asset(
                                            'assets/icons/Detail_Buttonblue.svg',
                                            width: 30,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(
                      child: Text('Aucune activité trouvée'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

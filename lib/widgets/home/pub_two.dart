import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:LetsGo/theme/LetsGo_theme.dart';

import '../../constants/url.dart';
import '../../views/event/event_screen.dart';
import '../loader/loader.dart';

class PubTwo extends StatefulWidget {
  const PubTwo({Key? key}) : super(key: key);

  @override
  _PubTwoState createState() => _PubTwoState();
}

class _PubTwoState extends State<PubTwo> {
  Future<dynamic> _data = Future.value({});

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Stack(
            children: <Widget>[
              SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: snapshot.data['image'],
                    width: 66,
                    height: 66,
                    placeholder: (context, url) => const Loader(),
                    errorWidget: (context, url, error) => Image.network(
                        '${Uri.parse(AppUrl.baseUrlImage)}/${snapshot.data['image']}'),
                  )),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.415,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    colors: [
                      const Color(0xFF020E33).withOpacity(0.70),
                      const Color(0xFF020E33).withOpacity(0.70),
                      // Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Évènement à venir autour de vous',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: LetsGoTheme.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data['name'],
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: LetsGoTheme.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 20, 0, 0),
                            child: ExpandableText(
                              snapshot.data['description'] ?? '',
                              expandText: 'Voir plus',
                              collapseText: 'Voir moins',
                              maxLines: 5,
                              linkColor: Colors.white,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: LetsGoTheme.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 290,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                /* Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventScreen(activity: snapshot.data),
                                  ),
                                );*/
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: LetsGoTheme.transparent,
                                backgroundColor: LetsGoTheme.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(8), // <-- Radius
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Text(
                                  'Reserver',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: LetsGoTheme.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          /*SizedBox(
                            width: 290,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResetPassword(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: LetsGoTheme.transparent,
                                backgroundColor: LetsGoTheme.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                                ),
                                side: BorderSide(
                                  width: 2.0,
                                  color: LetsGoTheme.white,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Text(
                                  'Définir un rappel maintenant',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: LetsGoTheme.white,
                                  ),
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Loader();
      },
    );
  }

  Future<dynamic> fetchData() async {
    String url =
        '${AppUrl.baseUrl}/publications/pubTwo/51bd7192-bbb5-434a-8252-60ac478ada40';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

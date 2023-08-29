import 'dart:convert';

import 'package:LetsGo/theme/letsgo_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:http/http.dart' as http;

import '../../constants/url.dart';
import '../../database/db_provider.dart';

class AttendeeAdultCard extends StatefulWidget {
  const AttendeeAdultCard({Key? key}) : super(key: key);

  @override
  _AttendeeAdultCardState createState() => _AttendeeAdultCardState();
}

class _AttendeeAdultCardState extends State<AttendeeAdultCard> {
  final DatabaseProvider? db = DatabaseProvider();
  dynamic user;

  @override
  void initState() {
    db!.getUser().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> nbAdultsCards = [];
    for (int x = 1; x <= globals.nbAdult; x++) {
      nbAdultsCards.add(
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: (Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Color.fromARGB(51, 138, 138, 138),
                  offset: Offset(0, 2),
                )
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 280,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Adulte $x',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.badge,
                                color: Color(0xff4376FF),
                                size: 21,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    7, 0, 0, 0),
                                child: Text(
                                  '${user['full_name']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.email,
                                color: Color(0xff4376FF),
                                size: 21,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    7, 0, 0, 0),
                                child: Text(
                                  '${user['email']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Color(0xff4376FF),
                                size: 19,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 0, 0),
                                child: Text(
                                  globals.phone,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidMoneyBill1,
                                color: Color(0xff4376FF),
                                size: 17,
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    7, 0, 0, 0),
                                child: Text(
                                  '${globals.AdultValue + globals.ChildValue} €',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ),
      );
    }
    return Column(
      children: nbAdultsCards,
    );
  }
}

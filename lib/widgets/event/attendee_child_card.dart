import 'dart:convert';

import 'package:LetsGo/theme/letsgo_theme.dart';
import 'package:flutter/material.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:http/http.dart' as http;

import '../../constants/url.dart';

class AttendeeChildCard extends StatefulWidget {
  const AttendeeChildCard({Key? key}) : super(key: key);

  @override
  _AttendeeChildCardState createState() => _AttendeeChildCardState();
}

final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _phoneController = TextEditingController();

handleCreateGuestAccount() async {
  String url = '${AppUrl.baseUrl}/auth/createGuestAccount';

  final response = await http.post(Uri.parse(url), body: {
    'first_name': _firstNameController.text,
    'last_name': _lastNameController.text,
    'email': _emailController.text,
    'phone': _phoneController.text,
    'role': 'guest'
  });

  final responseJson = json.decode(response.body);
  print('responseJson: ${responseJson['GuestAccount']['id']}');

  globals.guestId = responseJson['GuestAccount']['id'];

  if (response.statusCode == 200) {
    String url = '${AppUrl.baseUrl}/reservations/create_reservation';

    final response = await http.post(Uri.parse(url), body: {
      'user_id': globals.guestId,
      'number_of_places': '${globals.nbAdult + globals.nbChild}',
      'time_of_session': '${globals.choiceTime}',
      'status': 'pending',
      'date_of_session': '${globals.slectedDate}',
      'total_price':
          '${(globals.nbAdult * globals.AdultValue) + (globals.nbChild * globals.ChildValue)}',
    });

    final responseReservation = json.decode(response.body);

    if (response.statusCode == 200) {
      globals.responseReservationId = responseReservation['reservation']['id'];
    } else {
      print('error');
    }
  } else {
    print('Guest account not created');
  }
}

// final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();

class _AttendeeChildCardState extends State<AttendeeChildCard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> nbChildCards = [];
    for (int x = 1; x <= globals.nbChild; x++) {
      nbChildCards.add(
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: (Container(
            width: double.infinity,
            height: 127,
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
                              'Enfant $x',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.badge,
                                color: Color(0xff4376FF),
                                size: 19,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                child: Text(
                                  'John DOE',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: const [
                              Icon(
                                Icons.email,
                                color: Color(0xff4376FF),
                                size: 19,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                child: Text(
                                  'john.doe@gmail.com',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 7, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.euro,
                                color: Color(0xff4376FF),
                                size: 19,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(7, 0, 0, 0),
                                child: Text(
                                  '${globals.ChildValue}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
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
      children: nbChildCards,
    );
  }
}

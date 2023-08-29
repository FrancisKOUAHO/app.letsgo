import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:http/http.dart' as http;

import '../../constants/url.dart';

class AttendeeChildForm extends StatefulWidget {
  const AttendeeChildForm({Key? key}) : super(key: key);

  @override
  _AttendeeChildFormState createState() => _AttendeeChildFormState();
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

  globals.phone = _phoneController.text;

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

class _AttendeeChildFormState extends State<AttendeeChildForm> {
  @override
  Widget build(BuildContext context) {
    List<Widget> nbChildsForm = [];
    for (int x = 1; x <= globals.nbChild; x++) {
      nbChildsForm.add(
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: (ExpansionTileCard(
            baseColor: Colors.grey.shade100,
            expandedColor: Colors.grey.shade100,
            expandedTextColor: const Color(0xff4376FF),
            shadowColor: const Color(0x320E151B),
            borderRadius: BorderRadius.circular(12),
            // key: cardA,
            title: Text('Enfant $x'),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: Form(
                    child: Column(
                      children: [
                        TextField(
                          controller: _firstNameController,
                          cursorColor: Colors.white,
                          cursorWidth: 2,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            focusColor: LetsGoTheme.main,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: LetsGoTheme.main),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: LetsGoTheme.transparent),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: LetsGoTheme.lightGrey),
                            ),
                            hintText: 'NOM',
                            disabledBorder: null,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon:
                                Icon(Icons.badge, color: LetsGoTheme.main),
                            hintStyle: TextStyle(
                              color: LetsGoTheme.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _lastNameController,
                          cursorColor: Colors.white,
                          cursorWidth: 2,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                            focusColor: LetsGoTheme.main,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: LetsGoTheme.main),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: LetsGoTheme.transparent),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: LetsGoTheme.lightGrey),
                            ),
                            hintText: 'Prénom',
                            disabledBorder: null,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon:
                                Icon(Icons.badge, color: LetsGoTheme.main),
                            hintStyle: TextStyle(
                              color: LetsGoTheme.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      );
    }
    return Column(
      children: nbChildsForm,
    );
  }
}

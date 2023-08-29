import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:LetsGo/views/summary/summary.dart';
import 'package:http/http.dart' as http;

import '../../constants/url.dart';
import '../../database/db_provider.dart';
import '../../theme/LetsGo_theme.dart';
import '../../utils/snack_message.dart';
import '../../widgets/custom_app_bar/custom_return_appbar_summary.dart';

class Attendees extends StatefulWidget {
  const Attendees({Key? key}) : super(key: key);

  @override
  _AttendeesState createState() => _AttendeesState();
}

class _AttendeesState extends State<Attendees> {
  late BuildContext _context;

  final DatabaseProvider? db = DatabaseProvider();
  final TextEditingController _phoneController = TextEditingController();

  dynamic user;
  bool _isLoading = false;

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
    _context = context;
    List<Widget> nbAdultsForms = [];
    nbAdultsForms.add(
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
        child: (ExpansionTileCard(
          baseColor: Colors.grey.shade100,
          expandedColor: Colors.grey.shade100,
          expandedTextColor: const Color(0xff4376FF),
          shadowColor: const Color(0x320E151B),
          borderRadius: BorderRadius.circular(12),
          // key: cardA,
          title: const Text('Adulte 1'),
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
                        cursorColor: Colors.white,
                        cursorWidth: 2,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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
                          hintText: '${user['full_name'].split(' ')[0]}',
                          // hintText: 'NOM',
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
                        cursorColor: Colors.white,
                        cursorWidth: 2,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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
                          hintText: '${user['full_name'].split(' ')[1]}',
                          // hintText: 'Prénom',
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
                        cursorColor: Colors.white,
                        cursorWidth: 2,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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
                          hintText: '${user['email'].split(' ')[0]}',
                          // hintText: 'Email',
                          disabledBorder: null,
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              Icon(Icons.email, color: LetsGoTheme.main),
                          hintStyle: TextStyle(
                            color: LetsGoTheme.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          globals.isvalidInputPhone = true;
                        },
                        controller: _phoneController,
                        cursorColor: Colors.white,
                        cursorWidth: 2,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 16),
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
                          hintText: 'Téléphone',
                          disabledBorder: null,
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              Icon(Icons.phone, color: LetsGoTheme.main),
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
    for (int x = 2; x <= globals.nbAdult; x++) {
      nbAdultsForms.add(
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
          child: (ExpansionTileCard(
            baseColor: Colors.grey.shade100,
            expandedColor: Colors.grey.shade100,
            expandedTextColor: const Color(0xff4376FF),
            shadowColor: const Color(0x320E151B),
            borderRadius: BorderRadius.circular(12),
            // key: cardA,
            title: Text('Adulte $x'),
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
                          cursorColor: Colors.white,
                          cursorWidth: 2,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
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
                          cursorColor: Colors.white,
                          cursorWidth: 2,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: LetsGoTheme.main,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: CustomReturnAppBarSummary(
              'Coordonnées', LetsGoTheme.transparent, LetsGoTheme.white),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.87,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x320E151B),
                    offset: Offset(0, -2),
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                  topLeft: Radius.circular(48),
                  topRight: Radius.circular(48),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: LetsGoTheme.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color.fromARGB(51, 138, 138, 138),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 12, 12, 8),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Coordonnées adultes',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(1, 0, 0, 0),
                                      child: Icon(
                                        Icons.man,
                                        color: LetsGoTheme.main,
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: nbAdultsForms,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await _asyncSaveUser();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LetsGoTheme.main,
                              minimumSize: const Size(0, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            child: _isLoading && globals.isvalidInputPhone
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Voir le récapitulatif',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _asyncSaveUser() async {
    String url = '${AppUrl.baseUrl}/auth/updateUser/${globals.userID}';

    final response = await http.put(Uri.parse(url),
        body: {'phone': _phoneController.text, 'role': 'guest'});
    final responseJson = json.decode(response.body);
    if (response.statusCode == 200) {
      globals.phone = _phoneController.text;
      globals.guestId = responseJson['data']['id'];
      String url = '${AppUrl.baseUrl}/reservations/create_reservation';

      final response = await http.post(Uri.parse(url), body: {
        'user_id': globals.guestId,
        'activity_id': globals.activityId,
        'organisator_id': globals.organisatorId,
        'number_of_places': '${globals.nbAdult + globals.nbChild}',
        'time_of_session': '${globals.choiceTime}',
        'status': 'pending',
        'date_of_session': '${globals.slectedDate}',
        'total_price':
            '${(globals.nbAdult * globals.AdultValue) + (globals.nbChild * globals.ChildValue)}',
      });

      final responseReservation = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        globals.responseReservationId =
            responseReservation['reservation']['id'];
        Navigator.push(
          _context,
          MaterialPageRoute(
            builder: (context) => Summary(),
          ),
        );
      } else {
        showMessageErreur(
            message: 'Une erreur est survenue, veuillez réessayer',
            context: context);
        Navigator.pop(context);
      }
    } else {
      showMessage(
          message: 'Veuillez remplir le champ téléphone', context: context);
      print('Guest account not created');
    }
  }
}

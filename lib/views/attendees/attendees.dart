import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../constants/url.dart';
import '../../theme/LetsGo_theme.dart';
import '../../utils/snack_message.dart';
import '../../widgets/custom_app_bar/custom_return_appbar_summary.dart';
import '../../globals.dart' as globals;
import '../summary/summary.dart';

class Attendees extends StatefulWidget {
  const Attendees({Key? key}) : super(key: key);

  @override
  _AttendeesState createState() => _AttendeesState();
}

class _AttendeesState extends State<Attendees> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> nbAdultsForms = [];

    // Code ExpansionTileCard pour les adultes
    for (int x = 1; x <= globals.nbAdult; x++) {
      nbAdultsForms.add(
        Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: ExpansionTileCard(
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
                            controller: _fullNameController,
                            cursorColor: Colors.black,
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
                              hintText: 'Nom Complet',
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
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  globals.isValidInputFullName = true;
                                });
                              } else {
                                setState(() {
                                  globals.isValidInputFullName = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _emailController,
                            cursorColor: Colors.black,
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
                              hintText: 'email',
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
                            onChanged: (value) {
                              // Validez la saisie du numéro de téléphone et mettez à jour isValidInputPhone
                              if (value.isNotEmpty) {
                                setState(() {
                                  globals.isValidInputEmail = true;
                                });
                              } else {
                                setState(() {
                                  globals.isValidInputEmail = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          IntlPhoneField(
                            autofocus: false,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: const EdgeInsets.all(16),
                              isCollapsed: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            initialCountryCode: 'FR',
                            languageCode: 'fr',
                            controller: _phoneController,
                            onChanged: (value) {
                              // Validez la saisie du numéro de téléphone et mettez à jour isValidInputPhone
                              if (value.completeNumber.length == 12) {
                                setState(() {
                                  globals.isValidInputPhone = true;
                                });
                              } else {
                                setState(() {
                                  globals.isValidInputPhone = false;
                                });
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
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
            'Coordonnées',
            LetsGoTheme.transparent,
            LetsGoTheme.white,
          ),
        ),
        body: Padding(
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
                            12,
                            12,
                            12,
                            8,
                          ),
                          child: Column(
                            children: [
                              const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Coordonnées adultes',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
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
                          onPressed: _isLoading ||
                                  !globals.isValidInputPhone ||
                                  !globals.isValidInputEmail ||
                                  !globals.isValidInputFullName
                              ? null
                              : () async {
                                  await _asyncSaveUser();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LetsGoTheme.main,
                            minimumSize: const Size(0, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
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
    );
  }

  Future<void> _asyncSaveUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String url = '${AppUrl.baseUrl}/reservations/create_reservation';

      final Map<String, String> requestBody = {
        'full_name': _fullNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'activity_id': globals.activityId,
        'number_of_places': '${globals.nbAdult}',
        'time_of_session': '${globals.choiceTime}',
        'status': 'pending',
        'date_of_session': '${globals.selectedDate}',
        'total_price': '${(globals.nbAdult * globals.adultValue)}',
      };

      globals.phoneController = _phoneController.text;
      globals.emailController = _emailController.text;
      globals.fullNameController = _fullNameController.text;

      if (globals.guestId != null) {
        requestBody['user_id'] = globals.guestId;
      }

      if (globals.organisatorId != null) {
        requestBody['organisator_id'] = globals.organisatorId;
      }

      final response = await http.post(Uri.parse(url), body: requestBody);

      final responseReservation = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });
        globals.responseReservationId =
            responseReservation['reservation']['id'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Summary(),
          ),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        showMessageErreur(
            message:
                'Une erreur est survenue lors de la réservation, veuillez réessayer',
            context: context);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showMessageErreur(
          message: 'Une erreur s\'est produite : $e', context: context);
    }
  }
}

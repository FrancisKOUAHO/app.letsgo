import 'package:LetsGo/views/attendees/attendees.dart';
import 'package:flutter/material.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:LetsGo/views/payment/payment.dart';

import '../../theme/LetsGo_theme.dart';
import '../../widgets/custom_app_bar/custom_return_appbar.dart';
import '../../widgets/event/attendee_adult_card.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  var nameAdult1;
  var choiceTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: LetsGoTheme.main,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: CustomReturnAppBar(
            'Récapitulatif', LetsGoTheme.transparent, LetsGoTheme.white),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Billets adultes (x${globals.nbAdult})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(1, 0, 0, 0),
                          child: Icon(
                            Icons.man,
                            color: LetsGoTheme.main,
                            size: 25.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: const [
                        AttendeeAdultCard(),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    /*Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Billets enfants (x${globals.nbChild})',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Icon(
                                Icons.escalator_warning,
                                color: LetsGoTheme.main,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),*/
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Column(
                    //   children: const [
                    //     AttendeeChildCard(),
                    //   ],
                    // ),
                  ],
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.19),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Payment(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: LetsGoTheme.main,
                          minimumSize: const Size(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: const Text(
                          'Passer au paiement',
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
    );
  }
}

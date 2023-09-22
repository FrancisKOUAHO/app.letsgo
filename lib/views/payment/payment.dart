import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:http/http.dart' as http;

import '../../constants/url.dart';
import '../../database/db_provider.dart';
import '../../theme/LetsGo_theme.dart';
import '../../utils/routers.dart';
import '../../utils/snack_message.dart';
import '../../widgets/custom_app_bar/custom_return_appbar.dart';
import '../state_payment/success.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final DatabaseProvider? db = DatabaseProvider();
  final controller = CardEditController();
  dynamic user;
  bool _isLoading = false;

  @override
  void initState() {
    controller.addListener(update);
    db!.getUser().then((value) {
      setState(() {
        user = value;
      });
    });
    super.initState();
  }

  void update() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: LetsGoTheme.main,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 60),
          child: CustomReturnAppBar(
              'Paiement', LetsGoTheme.transparent, LetsGoTheme.white),
        ),
        body: SingleChildScrollView(
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
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const CardField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            labelText: 'Card',
                            hintText: '4242 4242 4242 4242',
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: LetsGoTheme.white,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.local_activity_outlined,
                                      color: LetsGoTheme.main,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 2, 0, 0),
                                      child: Text(
                                        '${globals.nbAdult + globals.nbChild} réservation(s)',
                                        style: const TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: LetsGoTheme.white,
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 0, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.calendar_today_outlined,
                                      color: LetsGoTheme.main,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 2, 0, 0),
                                      child: Text(
                                        '${globals.selectedDate.day}/${globals.selectedDate.month}/${globals.selectedDate.year}',
                                        style: const TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      color: LetsGoTheme.main,
                                      size: 20,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              10, 2, 0, 0),
                                      child: Text(
                                        globals.choiceTime ?? '00:00',
                                        style: const TextStyle(
                                          fontFamily: 'Outfit',
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Adulte(s)',
                                    style: TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            6, 0, 0, 0),
                                    child: Text(
                                      'x${globals.nbAdult}',
                                      style: const TextStyle(
                                        fontFamily: 'Outfit',
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '${globals.nbAdult * globals.adultValue}€',
                                    style: const TextStyle(
                                      fontFamily: 'Outfit',
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Sous-total',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '${(globals.nbAdult * globals.adultValue) + (globals.nbChild * globals.adultValue)}€',
                                  style: const TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: LetsGoTheme.main,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  '${(globals.nbAdult * globals.adultValue) + (globals.nbChild * globals.childValue)}€',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: LetsGoTheme.main,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              try {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() {
                                  _isLoading = true;
                                });

                                final paymentMethod =
                                    await Stripe.instance.createPaymentMethod(
                                        params: PaymentMethodParams.card(
                                  paymentMethodData: PaymentMethodData(
                                    billingDetails: BillingDetails(
                                      email: globals.emailController,
                                      phone: globals.phoneController,
                                      name: globals.fullNameController,
                                    ),
                                  ),
                                ));

                                globals.paymentMethodId = paymentMethod.id;

                                String url =
                                    '${AppUrl.baseUrl}/payments/create_payment';

                                final Map<String, String> requestBody = {
                                  'TokenIdStripe': globals.paymentMethodId,
                                  'reservation_id':
                                      globals.responseReservationId,
                                  'amount':
                                      '${(globals.nbAdult * globals.adultValue)}'
                                };

                                if (globals.userID != null) {
                                  requestBody['user_id'] = globals.userID;
                                }

                                final response = await http.post(Uri.parse(url),
                                    body: requestBody);

                                final jsonResponse = jsonDecode(response.body);

                                if (jsonResponse['success'] == true) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  PageNavigator(ctx: context)
                                      .nextPageOnly(page: const Success());
                                }
                              } catch (error) {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (error is StripeException) {
                                  showMessageErreur(
                                    message:
                                        'Erreur de paiement : ${error.error.localizedMessage}',
                                    context: context,
                                  );
                                } else {
                                  showMessageErreur(
                                    message:
                                        'Une erreur inattendue est survenue. Réessayez dans quelques secondes.',
                                    context: context,
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: LetsGoTheme.main,
                              minimumSize: const Size(0, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Payer',
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
}

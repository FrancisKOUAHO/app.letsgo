import 'package:LetsGo/views/home/home.dart';
import 'package:LetsGo/views/login/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/globals.dart' as globals;

import '../../constants/url.dart';
import '../../database/db_provider.dart';
import '../../utils/routers.dart';
import 'edit_profile.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  bool isActive = false;

  final double profilHeight = 144;

  dynamic _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    if (_user != null) ...[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: Text(
                                  '_user',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 0),
                                child: Text(
                                  globals.currentAddress ??
                                      '${globals.currentAddress.substring(0, 10)}...',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xBA777777),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ] else ...[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25, 10, 0, 25),
                                child: Text(
                                  'Accédez à votre réservation depuis n\'importe quel appareil',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    25, 10, 0, 25),
                                child: Text(
                                  'Inscrivez-vous, importez vos réservations existantes, ajoutez des activités à vos favoris et passez commande plus rapidement grâce aux coordonnées enregistrées.',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0xBA777777),
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              PageNavigator(ctx: context)
                                  .nextPageOnly(page: const SignIn());
                            },
                            child: const Text('Connectez-vous'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 25, right: 10),
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 16, 0, 0),
                            child: Text(
                              'Compte',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 10, 20, 0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (_user != null) ...[
                                      buildAccountOptionRow(
                                          context, 'Paramètres du compte'),
                                      const Divider(thickness: 1),
                                    ],
                                    buildAccountOptionRow(context, 'Social'),
                                    const Divider(thickness: 1),
                                    buildAccountOptionRow(context, 'Langue'),
                                    const Divider(thickness: 1),
                                    buildAccountOptionRow(
                                        context, 'Vie privée et sécurité'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (_user != null) ...[
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                              child: Text(
                                'Avancé',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  color: Color(0xFF14181B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 10, 20, 0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 20, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildNotificationOptionRow(
                                          'Supprimer son compte'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  DatabaseProvider().logOut(context);
                                },
                                child: const Text('Se déconnecter',
                                    style: TextStyle(color: Colors.redAccent)),
                              ),
                            )
                          ] else
                            ...[],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EditProfilePage()));
      },
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.67,
              decoration: const BoxDecoration(),
              child: Container(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildNotificationOptionRow(String title) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        shape: BoxShape.rectangle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.56,
            decoration: const BoxDecoration(),
            child: Container(
              padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: CupertinoColors.activeBlue,
              value: isActive,
              onChanged: (bool? val) {
                setState(() {
                  isActive = val!;
                });
                if (val!) {
                  showAlertDialog(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text('Annuler', style: TextStyle(color: Colors.black)),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: const Text('Oui, je suis sûr',
        style: TextStyle(color: Colors.redAccent)),
    onPressed: () async {
      final requestBaseUrl = AppUrl.baseUrl;

      String url = '$requestBaseUrl/auth/deleteAccount/${globals.userID}';
      http.Response req = await http.delete(Uri.parse(url));

      if (req.statusCode == 200 || req.statusCode == 201) {
        Fluttertoast.showToast(
            msg: 'Votre compte a été supprimé',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        PageNavigator(ctx: context).nextPageOnly(page: const Home());
      } else {
        Fluttertoast.showToast(
            msg: 'Une erreur est survenue',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Align(
      alignment: Alignment.center,
      child: Text(
        'Étes-vous sûr de vouloir supprimer votre compte ?',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    ),
    content: const Text(
        'Cette action est irréversible, vous perdrez toutes vos données',
        style: TextStyle(color: Colors.black, fontSize: 14)),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

import 'package:LetsGo/views/home/home.dart';
import 'package:LetsGo/views/login/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/globals.dart' as globals;

import '../../constants/url.dart';
import '../../database/db_provider.dart';
import '../../theme/LetsGo_theme.dart';
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
    DatabaseProvider().checkAuthentication(context);
    DatabaseProvider().getUser().then((value) {
      if (mounted) {
        setState(() {
          _user = value;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 40,
                    ),
                    if (_user != null) ...{
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: Text(
                              _user['full_name'],
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 0, 0, 0),
                            child: Text(
                              'kouahofrancis@gmail.com',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: LetsGoTheme.main,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, top: 25, right: 10),
                            child: Column(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 16, 0, 0),
                                      child: Text(
                                        'COMPTE',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF292929),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 10, 20, 0),
                                      child: Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0654,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 10, 20, 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (_user != null) ...{
                                                buildAccountOptionRow(context,
                                                    'Informations personnelles'),
                                              },
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 16, 0, 0),
                                      child: Text(
                                        'PARAMÈTRES',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF292929),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 10, 20, 0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 10, 20, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (_user != null) ...{
                                                buildAccountOptionRow(
                                                    context, 'Ville actuelle'),
                                                const Divider(thickness: 1),
                                                buildAccountOptionRow(context,
                                                    'Gestion des notifications'),
                                              },
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 16, 0, 0),
                                      child: Text(
                                        'SUPPORT',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF292929),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 10, 20, 0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 10, 20, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (_user != null) ...{
                                                buildAccountOptionRow(
                                                    context, 'Centre d\'aide'),
                                                const Divider(thickness: 1),
                                                buildAccountOptionRow(context,
                                                    'Suggérer des améliorations'),
                                              },
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 16, 0, 0),
                                      child: Text(
                                        'SUPPORT',
                                        style: TextStyle(
                                          fontFamily: 'Outfit',
                                          color: Color(0xFF292929),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 10, 20, 0),
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 10, 20, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (_user != null) ...{
                                                buildAccountOptionRow(context,
                                                    'Termes d\'utilisation et confidentialité'),
                                              },
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (_user != null) ...{
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(20, 10, 20, 0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(0, 10, 0, 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 45,
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        Colors.redAccent,
                                                      ),
                                                      shape:
                                                          MaterialStateProperty
                                                              .all(
                                                        const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(8),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Supprimer son compte',
                                                      style: TextStyle(
                                                        fontFamily: 'Late',
                                                        fontSize: 14,
                                                        color:
                                                            LetsGoTheme.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      showAlertDialog(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(20, 0, 20, 0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 10, 0, 10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 45,
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          const Color(
                                                              0xFFF1F1F1),
                                                        ),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Déconnexion',
                                                        style: TextStyle(
                                                          fontFamily: 'Late',
                                                          fontSize: 14,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        DatabaseProvider()
                                                            .logOut(context);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    } else
                                      ...{},
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    } else ...{
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    35, 35, 35, 35),
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
                                    30, 30, 25, 30),
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
                    },
                  ],
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
        height: MediaQuery.of(context).size.height * 0.03,
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
                        fontSize: 14,
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
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) async {
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
      if (globals.userID == null) {
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
      } else {
        // Gérer le cas où globals.userID est null
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

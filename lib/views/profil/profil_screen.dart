import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:LetsGo/views/booking/list_booking.dart';
import 'package:LetsGo/views/login/sign_in.dart';
import 'package:LetsGo/globals.dart' as globals;

import '../../constants/url.dart';
import '../../database/db_provider.dart';
import '../../widgets/custom_app_bar/custom_profil_appbar.dart';
import '../../widgets/loader/loader.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final double profilHeight = 144;
  final DatabaseProvider? db = DatabaseProvider();

  dynamic _user;

  @override
  void initState() {
    super.initState();
    db!.getUser().then((value) => setState(() {
          _user = value;
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: db!.getUser(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          _user = snapshot.data;
          return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: const PreferredSize(
                preferredSize: Size(double.infinity, 60),
                child: CustomProfilAppBar(),
              ),
              body: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14.0),
                                  child: CachedNetworkImage(
                                      imageUrl:
                                      '${Uri.parse(AppUrl.baseUrlImage)}/${_user['photo']}',
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Loader(),
                                      errorWidget: (context, url, error) => const Image(image: NetworkImage('https://images.unsplash.com/photo-1600480505021-e9cfb05527f1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2066&q=80'))),
                                ),
                              ),
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
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          InkWell(
                            onTap: null,
                            child: SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.sports_basketball_outlined,
                                    color: LetsGoTheme.main,
                                    size: 23,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'ACTIVITÉS',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '${globals.nbReservation}',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ListBooking()),
                              );
                            },
                            child: SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.local_activity_outlined,
                                    color: LetsGoTheme.main,
                                    size: 23,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'RESERVATION',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '${globals.nbReservation}',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            child: SizedBox(
                              width: 110,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.favorite_border,
                                    color: LetsGoTheme.main,
                                    size: 23,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    'FAVORIS',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: LetsGoTheme.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _goto() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SignIn()),
    );
  }
}

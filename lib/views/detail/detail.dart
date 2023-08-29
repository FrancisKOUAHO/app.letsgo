import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:LetsGo/globals.dart' as globals;
import 'package:LetsGo/views/attendees/attendees.dart';

import '../../constants/url.dart';
import '../../theme/LetsGo_theme.dart';
import '../../widgets/custom_app_bar/custom_return_appbar.dart';

class Detail extends StatefulWidget {
  final activity;

  const Detail({Key? key, required this.activity}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  List<String> timeActivity = [];
  var nameAdult1;
  var choiceTime;

  @override
  void initState() {
    for (var i = 0; i < widget.activity.schedule['dates'].length; i++) {
      for (var j = 0;
          j < widget.activity.schedule['dates'][i]['hours'].length;
          j++) {
        timeActivity.add(widget.activity.schedule['dates'][i]['hours'][j]);
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    globals.AdultValue = int.parse(widget.activity.price.replaceAll('€', ''));
    return Scaffold(
      backgroundColor: LetsGoTheme.main,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: CustomReturnAppBar(
            'Détails', LetsGoTheme.transparent, LetsGoTheme.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 11, 0, 0),
        child: Container(
          width: double.infinity,
          // height: MediaQuery.of(context).size.height * 0.87,
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
                            12, 12, 12, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: CachedNetworkImage(
                                imageUrl: widget.activity.image!,
                                width: 66,
                                height: 100,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.network(
                                        '${Uri.parse(AppUrl.baseUrlImage)}/${widget.activity.image}'),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    17, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.activity.name!,
                                      style: const TextStyle(
                                        color: Color(0xFF1D2429),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: Text(
                                        widget.activity.address ??
                                            'Adresse non renseignée',
                                        style: const TextStyle(
                                          color: Color(0xFF57636C),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                            12, 18, 12, 18),
                        child: Form(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Heure de la réservation',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: Colors.grey,
                                  backgroundColor: Colors.grey.shade100,
                                  minimumSize: const Size(400, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.schedule,
                                        color: LetsGoTheme.main,
                                        size: 25.0,
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          choiceTime ?? 'Choisissez une heure',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                              color: LetsGoTheme.black),
                                        ))
                                  ],
                                ),
                                onPressed: () => showMaterialScrollPicker(
                                  context: context,
                                  title: 'Heure de la réservation',
                                  items: timeActivity,
                                  selectedItem: choiceTime,
                                  onChanged: (value) => setState(() =>
                                      choiceTime = globals.choiceTime = value),
                                  headerColor: LetsGoTheme.main,
                                  buttonTextColor: LetsGoTheme.main,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Billets adultes ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '(${widget.activity.price!}€/pers)',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  foregroundColor: Colors.grey,
                                  backgroundColor: Colors.grey.shade100,
                                  minimumSize: const Size(400, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12), // <-- Radius
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(
                                        Icons.supervisor_account,
                                        color: LetsGoTheme.main,
                                        size: 25.0,
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '${globals.nbAdult}',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.normal,
                                              color: LetsGoTheme.black),
                                        ))
                                  ],
                                ),
                                onPressed: () => showMaterialNumberPicker(
                                  context: context,
                                  title: 'Nombre de billets adultes',
                                  minNumber: 0,
                                  maxNumber: 1,
                                  selectedNumber: globals.nbAdult,
                                  headerColor: LetsGoTheme.main,
                                  buttonTextColor: LetsGoTheme.main,
                                  onChanged: (value) => setState(() => {
                                        globals.nbAdult = value,
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                              builder: (context) => const Attendees(),
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
                          'Renseigner les coordonnées',
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

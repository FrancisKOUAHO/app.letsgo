import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/globals.dart' as globals;

import '../../constants/url.dart';
import '../../database/db_provider.dart';
import '../../models/reservation.model.dart';
import '../ticket/ticket.dart';

class BookingsComing extends StatefulWidget {
  const BookingsComing({Key? key}) : super(key: key);

  @override
  State<BookingsComing> createState() => _BookingsComingState();
}

class _BookingsComingState extends State<BookingsComing> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Reservation>> getReservationList() async {
    String url =
        '${AppUrl.baseUrl}/reservations/reservationId/${globals.userID}';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      final List<Reservation> reservations =
          jsonList.map((json) => Reservation.fromJson(json)).toList();

      return reservations;
    } else {
      throw Exception('Erreur lors de la récupération des réservations');
    }
  }

  Widget buildReservations(List<Reservation> reservations) {
    if (reservations.isEmpty) {
      return const Center(
        child: Text('Pas de réservations'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(3),
      itemCount: reservations.length,
      itemBuilder: (context, index) {
        final reservation = reservations[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Ticket(myReservation: reservation),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color.fromARGB(51, 138, 138, 138),
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(0),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: reservation.activities!['image'],
                            width: 66,
                            height: MediaQuery.of(context).size.height * 0.15,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.network(
                                '${Uri.parse(AppUrl.baseUrlImage)}/${reservation.activities!['image']}'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 260,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: Text(
                                          '${reservation.activities!['name'] ?? ''}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 15, 0, 0),
                                        child: Container(
                                          width: 260,
                                          decoration: const BoxDecoration(
                                            color: Colors.transparent,
                                          ),
                                          child: Text(
                                            'Réservation pour : ${reservation.numberOfPlaces ?? ''}',
                                            style: const TextStyle(
                                              color: Color(0xFFA0A0A0),
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 20, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 5, 0),
                                                  child: Icon(
                                                    Icons.qr_code,
                                                    color: Colors.black,
                                                    size: 16,
                                                  ),
                                                ),
                                                Text(
                                                  reservation.dateOfSession
                                                          ?.substring(0, 10) ??
                                                      reservation.dateOfSession!
                                                          .substring(0, 9),
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 5, 0),
                                                    child: Icon(
                                                      Icons.access_time,
                                                      color: Colors.black,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    reservation.timeOfSession!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(20, 0, 0, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 5, 0),
                                                    child: Icon(
                                                      Icons.euro,
                                                      color: Colors.black,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    reservation.totalPrice ??
                                                        '',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15,
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
                                ],
                              ),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservation>>(
      future: getReservationList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final reservations = snapshot.data!;
          return buildReservations(reservations);
        } else {
          return const Center(
            child: Text('Aucune réservation'),
          );
        }
      },
    );
  }
}

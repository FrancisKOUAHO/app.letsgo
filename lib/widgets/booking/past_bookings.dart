import 'package:flutter/material.dart';

class PastBookings extends StatefulWidget {
  const PastBookings({Key? key}) : super(key: key);

  @override
  State<PastBookings> createState() => _PastBookingsState();
}

class _PastBookingsState extends State<PastBookings> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Generated code for this Row Widget...
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
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
                        child: Image.network(
                          'https://picsum.photos/seed/180/600',
                          width: 80,
                          height: MediaQuery.of(context).size.height * 0.13,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.13,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEEEEEE),
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
                                      child: const Text(
                                        'Escapade en montagne accompagné',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional
                                          .fromSTEB(0, 5, 0, 0),
                                      child: Container(
                                        width: 260,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: const Text(
                                          'Réservé par : Jacky .T',
                                          style: TextStyle(
                                            color: Color(0xFFA0A0A0),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional
                                          .fromSTEB(0, 5, 0, 0),
                                      child: Container(
                                        width: 260,
                                        decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                        ),
                                        child: const Text(
                                          'Réservation pour : 10 Adultes, 4 Enfants',
                                          style: TextStyle(
                                            color: Color(0xFFA0A0A0),
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional
                                          .fromSTEB(0, 7, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 5, 0),
                                                child: Icon(
                                                  Icons.qr_code,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                              ),
                                              Text(
                                                '12:30',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.normal,
                                                  fontSize: 14,
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
                                              children: const [
                                                Padding(
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
                                                  '12:45',
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    fontSize: 14,
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
                                              children: const [
                                                Padding(
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
                                                  '25.00',
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.normal,
                                                    fontSize: 14,
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
                )
              ]),
        );
      },
    );
  }
}

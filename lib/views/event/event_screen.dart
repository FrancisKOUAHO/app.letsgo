import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:LetsGo/views/itinerary/itinerary.dart';
import 'package:LetsGo/views/detail/detail.dart';
import 'package:LetsGo/globals.dart' as globals;

import '../../config/url.dart';
import '../../theme/size-config-flutter.dart';
import '../../widgets/custom_app_bar/custom_event_appbar.dart';

class EventScreen extends StatefulWidget {
  final activity;

  const EventScreen({Key? key, required this.activity}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final Completer<GoogleMapController> _controllerMap =
      Completer<GoogleMapController>();
  List<DateTime> isActiveDate = [];
  BitmapDescriptor mapMarker = BitmapDescriptor.defaultMarker;

  final DatePickerController _controller = DatePickerController();
  bool isLoading = false;

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/map/Subtract.png');
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.activity.schedule['dates'].length; i++) {
      var dateConvert =
          convertDate(widget.activity.schedule['dates'][i]['date']);
      isActiveDate.add(dateConvert);
    }
    globals.activityId = widget.activity.id;
    globals.organisatorId = widget.activity.organisatorId ?? '';
    setCustomMarker();
  }

  DateTime convertDate(date) {
    var convertDate = DateFormat('MM-dd-yyyy').parse(date);
    return convertDate;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomEventAppBar(),
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: const AlignmentDirectional(0, -1),
            child: CachedNetworkImage(
              imageUrl: widget.activity.image!,
              width: double.infinity,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.network(
                  '${Uri.parse(AppUrl.baseUrlImage)}/${widget.activity.image}'),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, 1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 250, 0, 0),
                    child: Container(
                      width: double.infinity,
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(25, 30, 25, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width: 340,
                                        child: Text(
                                          widget.activity.name!,
                                          maxLines: 5,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: LetsGoTheme.main,
                                            fontSize: 27,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          '9.8 km',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const Text(
                                          '・',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF57636C),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 270,
                                          child: Text(
                                            widget.activity.address != null
                                                ? widget.activity.address!
                                                : '',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF57636C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            print('Button pressed ...');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: LetsGoTheme.main,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8), // <-- Radius
                                            ),
                                          ),
                                          child: const Text(
                                            'Appeler',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SizedBox(
                                          width: 331,
                                          child: ExpandableText(
                                            widget.activity.description != null
                                                ? widget.activity.description!
                                                : '',
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                            expandText: 'Voir plus',
                                            collapseText: 'Voir moins',
                                            maxLines: 5,
                                            linkColor: const Color(0xff4376FF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Stack(
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    child: GoogleMap(
                                      mapType: MapType.normal,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                          widget.activity.latitude,
                                          widget.activity.longitude,
                                        ),
                                        zoom: 9,
                                      ),
                                      markers: {
                                        Marker(
                                            markerId: const MarkerId('marker'),
                                            position: LatLng(
                                              widget.activity.latitude!,
                                              widget.activity.longitude!,
                                            ),
                                            icon: mapMarker),
                                      },
                                      myLocationEnabled: false,
                                      myLocationButtonEnabled: false,
                                      compassEnabled: false,
                                      zoomGesturesEnabled: true,
                                      zoomControlsEnabled: true,
                                      scrollGesturesEnabled: true,
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        _controllerMap.complete(controller);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      210, 185, 0, 0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Itinerary(),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8), // <-- Radius
                                      ),
                                    ),
                                    child: const Text(
                                      'Voir la map',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xff4376FF),
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 40, 0, 0),
                                  child: Text(
                                    'Réservation',
                                    style: LetsGoTheme.subTitle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            DatePicker(
                              DateTime.now(),
                              height: MediaQuery.of(context).size.height * 0.11,
                              initialSelectedDate: DateTime.now(),
                              selectionColor: LetsGoTheme.main,
                              deactivatedColor: Colors.grey,
                              controller: _controller,
                              selectedTextColor: Colors.white,
                              activeDates: isActiveDate,
                              locale: 'fr_FR',
                              onDateChange: (date) {
                                setState(() {
                                  isLoading = true;
                                  globals.selectedDate = date;
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            isLoading == false
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.activity.image!,
                                          width: double.infinity,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image.network(
                                                  '${Uri.parse(AppUrl.baseUrlImage)}/${widget.activity.image}'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 90, 0, 0),
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: LetsGoTheme.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 2,
                                                color: Color(0x33000000),
                                                offset: Offset(0, 1),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(15, 15, 15, 15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: LetsGoTheme.main,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: const Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(15, 5,
                                                                    15, 5),
                                                        child: Text(
                                                          'VISITE GUIDÉ',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 15, 0, 0),
                                                  child: Text(
                                                    widget.activity.name!,
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 10, 0, 10),
                                                  child: ExpandableText(
                                                    widget.activity
                                                                .description !=
                                                            null
                                                        ? widget.activity
                                                            .description!
                                                        : 'Aucune description',
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                    ),
                                                    expandText: 'Voir plus',
                                                    collapseText: 'Voir moins',
                                                    maxLines: 3,
                                                    linkColor:
                                                        const Color(0xff4376FF),
                                                  ),
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 10, 0, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'À partir de',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                    5, 0, 0, 0),
                                                            child: Text(
                                                              '${widget.activity.price} €',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 22,
                                                                color: Color(
                                                                    0xff4376FF),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Detail(
                                                                        activity:
                                                                            widget.activity),
                                                              ),
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shadowColor: Colors
                                                                .transparent,
                                                            backgroundColor:
                                                                LetsGoTheme
                                                                    .main,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8), // <-- Radius
                                                            ),
                                                            side:
                                                                const BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1,
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            'Réserver',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

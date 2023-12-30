import 'dart:convert';

import 'package:LetsGo/models/activity.model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../config/url.dart';
import '../../widgets/custom_app_bar/custom_return_appbar.dart';

class Itinerary extends StatefulWidget {
  @override
  _ItineraryState createState() => _ItineraryState();
}

class _ItineraryState extends State<Itinerary> {
  late BitmapDescriptor mapMarker = BitmapDescriptor.defaultMarker;
  final List<Marker> _markers = [];
  final List<Activity> activities = [];

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/map/Subtract.png');
  }

  @override
  void initState() {
    super.initState();
    setCustomMarker();
    getActivitiesList();
  }

  void getActivitiesList() async {
    String url = '${AppUrl.baseUrl}/activities/get_activities';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      for (var item in body) {
        activities.add(Activity.fromJson(item));
      }
      _createMarkers();
    }
  }

  void _createMarkers() {
    for (var element in activities) {
      _markers.add(
        Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(element.latitude, element.longitude),
          icon: mapMarker,
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomReturnAppBar('', Colors.transparent, Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(
                  48.856614,
                  2.3522219,
                ),
                zoom: 9,
              ),
              markers: Set<Marker>.of(_markers),
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              scrollGesturesEnabled: true,
              onMapCreated: _onMapCreated,
            ),
          ),
        ],
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {});
  }
}

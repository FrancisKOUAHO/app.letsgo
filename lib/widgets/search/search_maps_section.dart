
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../constants/url.dart';
import '../../models/activity.model.dart';
import '../../views/itinerary/itinerary.dart';

class SearchMapsSection extends StatefulWidget {
  const SearchMapsSection({Key? key}) : super(key: key);

  @override
  _SearchMapsSectionState createState() => _SearchMapsSectionState();
}

class _SearchMapsSectionState extends State<SearchMapsSection> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.5,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
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
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(225, 185, 0, 0),
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
                  borderRadius: BorderRadius.circular(8), // <-- Radius
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
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {});
  }
}

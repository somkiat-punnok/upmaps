import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsUPPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapsUPPage();
  }
}

final customTheme = ThemeData(
  primarySwatch: Colors.purple[700],
  brightness: Brightness.dark,
  accentColor: Colors.redAccent,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.00)),
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 12.50,
      horizontal: 10.00,
    ),
  ),
);

class _MapsUPPage extends State<MapsUPPage> {
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[700],
          title: Text("UNIVERSITY OF PHAYAO"),
          actions: <Widget>[
            // IconButton(
            //     icon: Icon(
            //       Icons.search,
            //       color: Colors.white,
            //     ),
            //     onPressed: null),
            //IconButton(icon: Icon(Icons.business), onPressed: _zoomOutToPhayao),
            IconButton(
                icon: Icon(Icons.school), onPressed: _goToUniversityOfPhayao),
          ]),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          bearing: 360.0, //หมุน
          target: LatLng(19.029037, 99.895317),
          zoom: 13.0,
          tilt: 45.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(19.0282768, 99.8959288),
            infoWindow:
                InfoWindow(title: "มหาวิทยาลัยพะเยา", snippet: "ตึกอธิการบดี"),
            //onTap: () => _openOnGoogleMapApp(19.0282768,99.8959288)
          ),
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(19.0273376, 99.8993972),
            infoWindow: InfoWindow(
                title: "ตึกเทคโนโลยีสารสนเทศและการสื่อสาร", snippet: "ตึก ICT"),
            //onTap: () => _openOnGoogleMapApp(19.0282768,99.8959288)
          ),
        },
        polylines: {
          Polyline(
              polylineId: PolylineId("p1"),
              color: Colors.red[300],
              points: [
                LatLng(19.033320, 99.926869),
                LatLng(19.035710, 99.921002),
                LatLng(19.037322, 99.912017),
                LatLng(19.040987, 99.882561),
                LatLng(19.033664, 99.877045),
                LatLng(19.027761, 99.882939),
                LatLng(19.020701, 99.889903),
                LatLng(19.020518, 99.904409),
                LatLng(19.025666, 99.918868),
                LatLng(19.029794, 99.918544),
                LatLng(19.028984, 99.925047),
                LatLng(19.033320, 99.926869),
              ])
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, right: 310.0),
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.near_me),
          onPressed: _goToMe,
        ),
      ),
    );
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

  Future _goToMe() async {
    final GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 16.0,
      tilt: 45.0,
    )));
  }

//ไปตึกอธิการบดี/ม.พะเยา
  Future _goToUniversityOfPhayao() async {
    final GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    controller
        .animateCamera(CameraUpdate.newLatLng(LatLng(19.0282768, 99.8959288)));
  }

// //เห็นทั้งพะเยา
//   Future _zoomOutToPhayao() async {
//     final GoogleMapController controller = await _controller.future;
//     currentLocation = await getCurrentLocation();
//     controller.animateCamera(
//         CameraUpdate.newLatLngZoom(LatLng(19.1659251, 99.8933242), 10.0));
//   }

  // _openOnGoogleMapApp(double latitude, double longitude) async {
  //   String googleUrl =
  //       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //   if (await canLaunch(googleUrl)) {
  //     await launch(googleUrl);
  //   } else {
  //     // Could not open the map.
  //   }
  // }

}

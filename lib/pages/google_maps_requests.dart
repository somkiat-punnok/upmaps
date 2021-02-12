import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';

const apiKey = "AIzaSyD2nte3n2Vl1AHTVWw_VK72MqRhhEVY6W0";

class GoogleMapsServices {
  Future<List<LatLng>> getRouteCoordinates(LatLng l1, LatLng l2) async {
    final List<LatLng> _points = <LatLng>[];

    DirectionsResponse _direct =
        await GoogleMapsDirections(apiKey: apiKey).directionsWithLocation(
      Location(l1.latitude, l1.longitude),
      Location(l2.latitude, l2.longitude),
    );

    _direct.routes.forEach((r) {
      r.legs.forEach((l) {
        l.steps.forEach((s) {
          _points.add(LatLng(s.startLocation.lat, s.startLocation.lng));
          _points.add(LatLng(s.endLocation.lat, s.endLocation.lng));
        });
      });
    });

    return _points;
  }
}

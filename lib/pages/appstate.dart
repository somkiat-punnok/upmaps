import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_up/pages/google_maps_requests.dart';
import 'package:url_launcher/url_launcher.dart';

class AppState with ChangeNotifier {
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  bool locationServiceActive = true;
  String typeUser;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController _mapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;

  bool _showroad1 = false;
  bool get showroad1 => _showroad1;
  void toggleShowroad1() {
    _showroad1 = !_showroad1;
    _showroad2 = false;
    _showroad3 = false;
    _showroad4 = false;
    _showroad5 = false;
    notifyListeners();
  }

  bool _showroad2 = false;
  bool get showroad2 => _showroad2;
  void toggleShowroad2() {
    _showroad1 = false;
    _showroad2 = !_showroad2;
    _showroad3 = false;
    _showroad4 = false;
    _showroad5 = false;
    notifyListeners();
  }

  bool _showroad3 = false;
  bool get showroad3 => _showroad3;
  void toggleShowroad3() {
    _showroad1 = false;
    _showroad2 = false;
    _showroad3 = !_showroad3;
    _showroad4 = false;
    _showroad5 = false;
    notifyListeners();
  }

  bool _showroad4 = false;
  bool get showroad4 => _showroad4;
  void toggleShowroad4() {
    _showroad1 = false;
    _showroad2 = false;
    _showroad3 = false;
    _showroad4 = !_showroad4;
    _showroad5 = false;
    notifyListeners();
  }

  bool _showroad5 = false;
  bool get showroad5 => _showroad5;
  void toggleShowroad5() {
    _showroad1 = false;
    _showroad2 = false;
    _showroad3 = false;
    _showroad4 = false;
    _showroad5 = !_showroad5;
    notifyListeners();
  }

  AppState() {
    _getUserLocation();
    _loadingInitialPosition();
  }

  // ! TO GET THE USERS LOCATION
  void _getUserLocation() async {
    print("get users");
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    print(
        "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
    print("initial position is : ${_initialPosition.toString()}");
    locationController.text = placemark[0].name;

    Geolocator()
        .getPositionStream(LocationOptions(accuracy: LocationAccuracy.high))
        .listen((pos) async {
      if (_lastPosition != null) {
        _initialPosition = LatLng(pos.latitude, pos.longitude);

        List<LatLng> _route = List.from(await _googleMapsServices
            .getRouteCoordinates(_initialPosition, _lastPosition));
        createRoute(_route);
      }
    });
    notifyListeners();
  }

  // ! TO CREATE ROUTE
  void createRoute(List<LatLng> points) {
    List<LatLng> _points = <LatLng>[];

    if (_initialPosition != null) {
      print("initialPosition: $_initialPosition");
      _points.add(_initialPosition);
    }

    _points.addAll(points);

    if (_lastPosition != null) {
      print("lastPosition: $_lastPosition");
      _points.add(_lastPosition);
    }

    // _points.forEach((p) {
    //   print("$p");
    // });

    _polyLines.clear();

    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 10,
        points: _points,
        color: Colors.black));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address, String url) {
    _markers.clear();
    _markers.add(Marker(
      markerId: MarkerId(_lastPosition.toString()),
      position: location,
      infoWindow: InfoWindow(
        title: address,
        snippet: "ดูรูป 3 มิติ",
        onTap: () async {
          if (await canLaunch(url ?? 'http://projectdriveup.com/')) {
            await launch(url ?? 'http://projectdriveup.com/');
          }
        },
      ),
      icon: BitmapDescriptor.defaultMarker,
      // onTap: () async {
      //   if (await canLaunch(url ?? 'http://projectdriveup.com/')) {
      //     await launch(url ?? 'http://projectdriveup.com/');
      //   }
      // },
    ));
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  // List<LatLng> _convertToLatLng(List points) {
  //   List<LatLng> result = <LatLng>[];
  //   for (int i = 0; i < points.length; i++) {
  //     if (i % 2 != 0) {
  //       result.add(LatLng(points[i - 1], points[i]));
  //     }
  //   }
  //   return result;
  // }

  // !DECODE POLY
//   List _decodePoly(String poly) {
//     var list = poly.codeUnits;
//     var lList = new List();
//     int index = 0;
//     int len = poly.length;
//     int c = 0;
// // repeating until all attributes are decoded
//     do {
//       var shift = 0;
//       int result = 0;

//       // for decoding value of one attribute
//       do {
//         c = list[index] - 63;
//         result |= (c & 0x1F) << (shift * 5);
//         index++;
//         shift++;
//       } while (c >= 32);
//       /* if value is negetive then bitwise not the value */
//       if (result & 1 == 1) {
//         result = ~result;
//       }
//       var result1 = (result >> 1) * 0.00001;
//       lList.add(result1);
//     } while (index < len);

// /*adding to previous value as done in encoding */
//     for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

//     print(lList.toString());

//     return lList;
//   }

  // ! SEND REQUEST
  void sendRequest({LatLng address, String name, String url}) async {
    // List<Placemark> placemark =
    //     await Geolocator().placemarkFromAddress(intendedLocation);
    // double latitude = placemark[0].position.latitude;
    // double longitude = placemark[0].position.longitude;
    // LatLng destination = LatLng(latitude, longitude);
    destinationController.text = name;
    _lastPosition = address;
    _addMarker(address, name, url);
    List<LatLng> _route = List.from(await _googleMapsServices
        .getRouteCoordinates(_initialPosition, address));
    createRoute(_route);
    notifyListeners();
  }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    // _lastPosition = position.target;
    // notifyListeners();
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  //  LOADING INITIAL POSITION
  void _loadingInitialPosition() async {
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if (_initialPosition == null) {
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:googlemaps/write_text.dart';
import 'package:geocoder/geocoder.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  Completer<GoogleMapController> _controller = Completer();

  Position destinationPosition;
  Set<Marker> _markers = {};

  CameraPosition _currentCameraPosition;

  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> routeCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCX7siqPOVR_DhIIq64VHiXhIXUgUZvVbU";

  LatLng latLng = LatLng(6.5, 3.4);
  TextEditingController _startController;
  TextEditingController _destinationController = TextEditingController();

  Timer _refreshPolyline;

  Function locationAddress;
  Geolocator geoLocator;
  StreamSubscription<Position> positionStream;
  String setAddress;
  BitmapDescriptor drivingPin, destinationPin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestPermissionLocation();
    _setMarkerIcon();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _refreshPolyline?.cancel();
    positionStream?.cancel();
    _destinationController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GoogleMap(
              onMapCreated: onMapCreated,
              polylines: Set<Polyline>.of(polyLines.values),
              initialCameraPosition: CameraPosition(
                target: latLng,
                zoom: 15.0,
              ),
              markers: Set<Marker>.from(_markers),
              // zoomControlsEnabled: false,
            ),
            Positioned(
              top: 50,
              child: WriteText(
                label: "Destination",
                hint: "Input a destination address",
                prefixIcon: Icon(Icons.looks_two),
                controllers: _destinationController,
                width: size.width,
                onComplete: () {
                  search();
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void onMapCreated(GoogleMapController googleMapController) {
    _controller.complete(googleMapController);
  }

  void _setMarkerIcon() async {
    drivingPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/driving_pin.png");
    destinationPin = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/destination_map_marker.png");
  }

  void _requestPermissionLocation() async {
    bool _locationService = await Geolocator.isLocationServiceEnabled();
    if (_locationService) {
      LocationPermission _permission = await Geolocator.checkPermission();
      if (_permission == LocationPermission.always) {
        _getLocation();
      } else {
        LocationPermission _requestPermission =
            await Geolocator.requestPermission();
        if (_requestPermission == LocationPermission.always) {
          _getLocation();
        }
      }
    }
  }

  void _getLocation() {
    positionStream = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 1,
    ).listen(
      (Position positions) async {
        if (positions == null) {
          print("Unknown");
        } else {
          print("Location: ${positions.toString()}");
          Coordinates coordinates =
              new Coordinates(positions.latitude, positions.longitude);
          List<Address> address =
              await Geocoder.local.findAddressesFromCoordinates(coordinates);
          setAddress = address.first.addressLine;
          // _startController = TextEditingController(text: setAddress);

          setState(() {
            latLng = LatLng(positions.latitude, positions.longitude);
          });

          _currentCameraPosition = CameraPosition(target: latLng, zoom: 15);
          final GoogleMapController _mapController = await _controller.future;
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(_currentCameraPosition),
          );

          setState(() {
            _markers.removeWhere((marker) => marker.markerId.value == "1");
            _markers.add(
              Marker(
                position: latLng,
                icon: drivingPin,
                markerId: MarkerId("1"),
              ),
            );
          });
        }
      },
    );
  }

  void search() async {
    setState(() {
      _markers.removeWhere((mark) => mark.markerId.value == "3");
      routeCoordinates.clear();
      // polyLines.clear();
    });
    try {
      List<Address> _endLocation = await Geocoder.local
          .findAddressesFromQuery(_destinationController.text);
      if(_endLocation.isEmpty){
        print("could not find address");
      }else{
        LatLng endPoint = LatLng(_endLocation.first.coordinates.latitude,
            _endLocation.first.coordinates.longitude);
        setState(() {
          _markers.add(
            Marker(
              markerId: MarkerId('3'),
              position: endPoint,
              infoWindow: InfoWindow(
                title: 'End',
              ),
              icon: destinationPin,
            ),
          );
        });
        destinationPosition = Position(latitude: endPoint.latitude, longitude: endPoint.longitude);
        // await _getPolyline();

        _refreshPolyline = Timer.periodic(Duration(seconds: 5), (timer) async {
          print("Updating");
          await _getPolyline();
        });

      }
    }catch (e, stack) {
      print("Error occured: $e $stack");
      }
  }

  Future <void> _getPolyline() async {
    Position _startPosition;
    List<Address> _startLocation =
        await Geocoder.local.findAddressesFromQuery(setAddress);
    LatLng startPoint = LatLng(_startLocation.first.coordinates.latitude,
        _startLocation.first.coordinates.longitude);
    _startPosition = Position(
        latitude: startPoint.latitude, longitude: startPoint.longitude);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_startPosition.latitude, _startPosition.longitude),
      PointLatLng(destinationPosition.latitude, destinationPosition.longitude),
      travelMode: TravelMode.driving,
    );
    routeCoordinates.clear();
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        routeCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print("it is empty");
    }
    setState(() {
      _addPolyLine();
    });
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: routeCoordinates, width: 4);
    polyLines[id] = polyline;
  }
}

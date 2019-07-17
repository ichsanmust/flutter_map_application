import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _center =  LatLng(-6.8973322, 107.6096949); // bandung
  LatLng _defaultPosition =  LatLng(-6.9033522,107.613184); // gedung sate
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  double lat;
  double lng;
  Geolocator geolocator = Geolocator();
  LatLng _currentPostion =  LatLng(0,0);
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    geolocator.getPositionStream().listen((position) {
//      print(position);
//      print(position.latitude);
      setState(() {
        lat = position.latitude;
        lng = position.longitude;
        //lat = -6.8902814;
        //lng = 107.6046514;
        _currentPostion = LatLng(lat,lng);

        _markers.add(Marker(
          markerId: MarkerId(_defaultPosition.toString()),
          position: _defaultPosition,
          infoWindow: InfoWindow(
            title: 'Gedung Sate',
//            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));

        _markers.add(Marker(
          markerId: MarkerId(_currentPostion.toString()),
          position: _currentPostion,
          infoWindow: InfoWindow(
            title: 'Your Location',
//            snippet: '5 Star Rating',
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.0,
          ),
          markers: _markers,
//          markers: {
//            Marker(
//              markerId: MarkerId(_defaultPosition.toString()),
//              position: _defaultPosition,
//              infoWindow: InfoWindow(
//                title: 'Gedung Sate',
//                snippet: '5 Star Rating',
//              ),
//              icon: BitmapDescriptor.defaultMarker,
//            ),
//            Marker(
//              markerId: MarkerId(_currentPostion.toString()),
//              position: _currentPostion,
//              infoWindow: InfoWindow(
//                title: 'Your Location',
//                snippet: '5 Star Rating',
//              ),
//              icon: BitmapDescriptor.defaultMarker,
//            )
//          }
        ),
      ),
    );
  }
}

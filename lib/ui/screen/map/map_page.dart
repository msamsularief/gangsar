import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:klinik/core/core.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];
  final Location _location = Location();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.3228857, 109.8966993),
    zoom: 11.0,
  );

  _getCurrentLocation() async {
    try {
      await _location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('PERMISSION_DENIED');
      }
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
    }

    // _oncameraMove(CameraPosition cameraPosition) {}

    _markers.add(
      Marker(
        markerId: MarkerId("Position"),
        position: LatLng(-8.0997773, 112.0046038),
      ),
    );

    return Container(
      width: Core.getDefaultAppWidth(context),
      height: Core.getDefaultBodyHeight(context),
      child: GoogleMap(
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        compassEnabled: false,
        // ignore: prefer_collection_literals
        gestureRecognizers: Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
        // onCameraMove: _oncameraMove,
      ),
    );
  }
}

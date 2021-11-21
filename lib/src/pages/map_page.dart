import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition _initialPosition =
        CameraPosition(target: scan.getLatLng(), zoom: 15, tilt: 25);

    Set<Marker> markers = <Marker>{};

    markers.add(
        Marker(markerId: MarkerId(scan.value), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location_sharp),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      zoom: 15, tilt: 25, target: scan.getLatLng())));
            },
          ),
        ],
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        markers: markers,
        mapType: mapType,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapType == MapType.normal
              ? mapType = MapType.hybrid
              : mapType = MapType.normal;
          setState(() {});
        },
        child: Icon(Icons.layers),
      ),
    );
  }
}

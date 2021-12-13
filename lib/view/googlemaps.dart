import 'dart:async';

import 'package:businessfinder/model/stores_data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() => runApp(MyApp());

class GoogleMaps extends StatelessWidget {
  final Stores tienda;

  GoogleMaps(this.tienda);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ubicación'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: GoogleMapsView(tienda),
      ),
    );
  }
}

class GoogleMapsView extends StatefulWidget {
  final Stores tienda;

  GoogleMapsView(this.tienda);

  @override
  State<GoogleMapsView> createState() => GoogleMapsViewState();
}

class GoogleMapsViewState extends State<GoogleMapsView> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {

    final CameraPosition _mainCamera = CameraPosition(
      target: LatLng(widget.tienda.latitude, widget.tienda.longitude),
      zoom: 17,
    );

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _mainCamera,
        markers: {
          Marker(
              markerId: MarkerId(widget.tienda.id.toString()),
              position: LatLng(widget.tienda.latitude, widget.tienda.longitude),
              infoWindow: InfoWindow(
                title: widget.tienda.name
              ),)
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {}
}

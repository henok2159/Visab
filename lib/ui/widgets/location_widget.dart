

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tourist_guide/models/location.dart';

class LocationWidget extends StatelessWidget {
  Location location;

  LocationWidget(this.location);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/3.5,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(
             location.lat,
              location.long),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          //_mapController.complete(controller);
        },
      ),
    );
  }
}

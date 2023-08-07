import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tourist_guide/data/places_api_service.dart';

class CurrentLocation{
      static LocationData? _locationData = null;

      static init() async{
        print("Currentlocation init");
        if(_locationData == null) {
          _locationData = await _getLocationData();
        }
      }
      static Future<LocationData?> getLocationData()async{
        if(_locationData == null){
          print("getcurrentlocation null case");
          _locationData = await _getLocationData();
        }
        return _locationData;
      }

      static Future<LocationData> _getLocationData() async {
        Location location = new Location();

        bool _serviceEnabled;
        PermissionStatus _permissionGranted;
        LocationData? _locationData;
        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            throw LocationPermissionException();
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            throw LocationPermissionException();
          }
        }

        _locationData = await location.getLocation();
        return _locationData;
      }
}


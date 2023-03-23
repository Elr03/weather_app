import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location service are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location service.
    return Future.error('Location service are disabled.');
  }
  //
  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied, '
        'we cannot request permissions.');
  }

  return Geolocator.getCurrentPosition();
}

Future<String> getPermission() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location service are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location service.
    return Future.value('Disabled');
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    try {
      permission = await Geolocator.requestPermission();
    } catch (e) {
      debugPrint(e.toString());
    }
    if (permission == LocationPermission.denied) {
      return Future.value('Permissions denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.value('Permissions permanently denied');
  }

  return Future.value('Permissions granted');
}

Future<bool> validatePermission() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location service are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location service.
    return false;
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    try {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return false;
  }
  return true;
}

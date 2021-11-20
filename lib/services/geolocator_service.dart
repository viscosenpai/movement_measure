import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  late double startLatitude;
  late double startLongitude;
  late double endLatitude;
  late double endLongitude;
  late LocationPermission permission;

  Future<Position> _getDeterminePosition() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> hasLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future<void> resolveLocationPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> setStartPosition() async {
    var startPosition = await _getDeterminePosition();
    startLatitude = startPosition.latitude;
    startLongitude = startPosition.longitude;
  }

  Future<void> setCurrntPosition() async {
    var currentPosition = await _getDeterminePosition();
    endLatitude = currentPosition.latitude;
    endLongitude = currentPosition.longitude;
  }

  double getBetweenDistance() {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters;
  }

  void eliminateDistance() {
    startLatitude = endLatitude;
    startLongitude = endLongitude;
  }
}

import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationServiceException(
        'Activa el GPS para registrar una evidencia.',
      );
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationServiceException(
        'Se necesita permiso de ubicación para continuar.',
      );
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationServiceException(
        'El permiso de ubicación está bloqueado. Actívalo desde los ajustes '
        'de la aplicación.',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 20),
      ),
    );
  }
}

class LocationServiceException implements Exception {
  const LocationServiceException(this.message);

  final String message;

  @override
  String toString() => message;
}

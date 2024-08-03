import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:paygo_fit/core/errors/exceptions.dart';
import 'package:paygo_fit/core/errors/failure.dart';

class LocationService {
  Future<Either<Failure, (Position coordinates, Placemark address)>>
      getCurrentLocationAddress() async {
    // Get the current location coordinates

    try {
      final position = await getCurrentLocationCoordinates();
      final address = await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );
      return Right((position, address));
    } on LocationException catch (le) {
      return Left(
        LocationFailure(
          message: le.message,
          statusCode: le.statusCode,
        ),
      );
    } catch (e) {
      return Left(
        LocationFailure(
          message: 'Error retrieving address: $e',
          statusCode: 500,
        ),
      );
    }
  }

  Future<Position> getCurrentLocationCoordinates() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   throw LocationException(
    //     message: 'Location services are disabled.',
    //     statusCode: 400,
    //   );
    // }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException(
          message: 'Location permissions are denied',
          statusCode: 400,
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        message:
            'Location permissions are permanently denied, we cannot request permissions.',
        statusCode: 400,
      );
    }

    // Get current position
    try {
      final position = await Geolocator.getCurrentPosition();

      return position;
    } catch (e) {
      throw LocationException(
        message:
            'Location permissions are permanently denied, we cannot request permissions.',
        statusCode: 400,
      );
    }
  }

  Future<Placemark> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return place;
      // return "${place.street}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}, ${place.country}";
    } else {
      throw Exception('Address not found');
    }
  }
}

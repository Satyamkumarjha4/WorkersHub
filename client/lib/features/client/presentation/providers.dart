import 'package:client/providers/dio_client_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final workersProvider = FutureProvider<Response>((ref) async {
  print("fetchWorkers called (via provider)");

  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) throw Exception('Location services are disabled');

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied');
    }
  }

  final position = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  );
  print("Got position: ${position.latitude}, ${position.longitude}");

  final dioClient = ref.read(dioClientProvider);
  final response = await dioClient.get(
    "/worker/getWorkerByRange",
    data: {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "range": 2,
    },
  );
  print("API response: ${response.data}");
  return response;
});

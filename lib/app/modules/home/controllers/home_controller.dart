import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool agreeButton = false.obs;
  RxDouble userLat = 0.0.obs;
  RxDouble userLong = 0.0.obs;
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition().then((value) {
      userLat.value = value.latitude;
      userLong.value = value.longitude;
    });
    return await Geolocator.getCurrentPosition();
  }

  Future findKm(double a3, double a4) async {
    double a1 = userLat.value;
    double a2 = userLong.value;
    double distanceInMeters = await Geolocator.distanceBetween(a1, a2, a3, a4);
    distanceInMeters /= 1000;

    return distanceInMeters.toString();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    determinePosition();
  }
}

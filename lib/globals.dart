import 'dart:math' as Math;

String userIdGlobal = 'none';
String userCityGlobal = 'none';
bool globalUserIsVaccinated = true;

var globalUserLocation = LatLng(-1, -1);
void changeGlobalUserIdValue(String id) {
  userIdGlobal = id;
}

void changeUserIsVaccinatedValue(bool value) {
  globalUserIsVaccinated = value;
}

void changeGlobalUserLocation(String location) {
  userCityGlobal = location;
}

void updateGlobalLocation(double lat, double lng) {
  globalUserLocation = LatLng(lat, lng);
}

class LatLng {
  final double latitude, longitude;
  LatLng(this.latitude, this.longitude);
}

double rad(double x) {
  return x * Math.pi / 180;
}

double getD(LatLng p1, LatLng p2) {
  double R = 6378137;
  double dLat = rad(p2.latitude - p1.latitude);
  double dLong = rad(p2.longitude - p1.longitude);
  double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(rad(p1.latitude)) *
          Math.cos(rad(p2.latitude)) *
          Math.sin(dLong / 2) *
          Math.sin(dLong / 2);
  double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c / 1000;
}

String generateLocationPreviewImage(
    {double latitude, double longitude, double width, double height}) {
  return 'https://tyler-demo.herokuapp.com/?lat=$latitude&lon=$longitude&zoom=17&width=${width ~/ 1.3}&height=${height ~/ 4}';
  // return 'https://staticmap.openstreetmap.de/staticmap.php?center=$latitude,$longitude&zoom=14&size=${height ~/ 4}x${width ~/ 1.3}&maptype=mapnik';
  // return 'https://osm-static-maps.herokuapp.com/?height=${height ~/ 4}&width=${(width / 1.3) ~/ 1}&center=$longitude,$latitude&zoom=18&markers=$longitude,$latitude,lightblue1';
}

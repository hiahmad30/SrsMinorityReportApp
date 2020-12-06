import 'package:geolocator/geolocator.dart';

class locationService {
  getlastPosition() async {
    try {
      Position position = await getLastKnownPosition();
      print("Lat: "+ position.latitude.toString()+" Long: " + position.longitude.toString());
      return position;
    } catch (e) {
      print(e.toString());
    }
  }
}

import 'package:geolocator/geolocator.dart';

class locationService {
  Future<Position> getlastPosition() async {
    try {
      Position position = await getLastKnownPosition();

      return position;
    } catch (e) {
      print(e.toString());
    }
  }
}

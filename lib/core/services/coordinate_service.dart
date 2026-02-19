import 'dart:math';

class Position {
  final double lng;
  final double lat;

  Position(this.lng, this.lat);
}

class CoordinateService {
  double getBearing(Position pointA, Position pointB) {
    double radianLatA = pointA.lat * pi / 180;
    double radianLongA = pointA.lng * pi / 180;
    double radianLatB = pointB.lat * pi / 180;
    double radianLongB = pointB.lng * pi / 180;

    double sigmaLong = radianLongB - radianLongA;
    double y = cos(radianLatB) * sin(sigmaLong);
    double x =
        cos(radianLatA) * sin(radianLatB) -
        sin(radianLatA) * cos(radianLatB) * cos(sigmaLong);
    return ((atan2(y, x) / pi * 180) + 360) % 360;
  }

  Position leftOffset(Position initPos, double offset, double bearing) {
    double radioOffsetX = offset * sin((bearing - 90) * pi / 180);
    double radioOffsetY = offset * cos((bearing - 90) * pi / 180);

    double earthRadius = 6371;
    double multiplier =
        (1 / ((2 * pi / 360) * earthRadius)) / 1000; // degree per meter
    double newLat = initPos.lat + (radioOffsetY * multiplier);
    double newLong =
        initPos.lng +
        (radioOffsetX * multiplier) / cos(initPos.lat * (pi / 180));
    return Position(newLong, newLat);
  }

  Position rightOffset(Position initPos, double offset, double bearing) {
    double radioOffsetX = offset * sin((bearing + 90) * pi / 180);
    double radioOffsetY = offset * cos((bearing + 90) * pi / 180);

    double earthRadius = 6371;
    double multiplier =
        (1 / ((2 * pi / 360) * earthRadius)) / 1000; // degree per meter
    double newLat = initPos.lat + (radioOffsetY * multiplier);
    double newLong =
        initPos.lng +
        (radioOffsetX * multiplier) / cos(initPos.lat * (pi / 180));
    return Position(newLong, newLat);
  }

  double getDistance(Position pointA, Position pointB) {
    var p = 0.017453292519943295;
    var a =
        0.5 -
        cos((pointB.lat - pointA.lat) * p) / 2 +
        cos(pointA.lat * p) *
            cos(pointB.lat * p) *
            (1 - cos((pointB.lng - pointA.lng) * p)) /
            2;
    return (12742 * asin(sqrt(a))) * 1000;
  }

  Position topOffset(Position initPos, double offset, double bearing) {
    double radioOffsetX = offset * sin((bearing) * pi / 180);
    double radioOffsetY = offset * cos((bearing) * pi / 180);

    double earthRadius = 6371;
    double multiplier =
        (1 / ((2 * pi / 360) * earthRadius)) / 1000; // degree per meter
    double newLat = initPos.lat + (radioOffsetY * multiplier);
    double newLong =
        initPos.lng +
        (radioOffsetX * multiplier) / cos(initPos.lat * (pi / 180));
    return Position(newLong, newLat);
  }

  Position bottomOffset(Position initPos, double offset, double bearing) {
    double radioOffsetX = offset * sin((bearing + 180) * pi / 180);
    double radioOffsetY = offset * cos((bearing + 180) * pi / 180);

    double earthRadius = 6371;
    double multiplier =
        (1 / ((2 * pi / 360) * earthRadius)) / 1000; // degree per meter
    double newLat = initPos.lat + (radioOffsetY * multiplier);
    double newLong =
        initPos.lng +
        (radioOffsetX * multiplier) / cos(initPos.lat * (pi / 180));
    return Position(newLong, newLat);
  }

  /// Generates a list of coordinates representing a circle polygon
  List<List<List<double>>> generateCirclePolygon(
    Position center,
    double radiusInMeters, {
    int steps = 36,
  }) {
    List<List<double>> coordinates = [];
    for (int i = 0; i < steps; i++) {
      double angle = (i * 360) / steps;
      Position point = topOffset(center, radiusInMeters, angle);
      coordinates.add([point.lng, point.lat]);
    }
    // Close the loop
    coordinates.add(coordinates.first);
    return [
      coordinates,
    ]; // GeoJSON Polygon format is [[[lng, lat], ...]] (Outer ring)
  }
}

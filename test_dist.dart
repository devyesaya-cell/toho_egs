import 'dart:convert';
import 'dart:io';
import 'dart:math';

class Position {
  final double lng;
  final double lat;

  Position(this.lng, this.lat);
}

class CoordinateService {
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
}

void main() async {
  final file = File('docs/RSKA082A01_Line_Sample_geo_simplify10cm_pr_gjson.geojson');
  final content = await file.readAsString();
  final data = json.decode(content);

  final feat = data['features'][0];
  final geom = feat['geometry'];
  List<dynamic> points;
  if (geom['type'] == 'MultiLineString') {
    points = geom['coordinates'][0];
  } else {
    points = geom['coordinates'];
  }

  final calc = CoordinateService();
  double totalDist = 0;
  
  print('Simulating 10 updates (100 seconds of Work Mode)...');
  for (int i = 0; i < 10 && i < points.length - 1; i++) {
    final p1 = Position(points[i][0] as double, points[i][1] as double);
    final p2 = Position(points[i+1][0] as double, points[i+1][1] as double);
    
    final dist = calc.getDistance(p1, p2);
    totalDist += dist;
    double production = totalDist * 4.0;
    print('Tick ${i+1}: Segment distance = ${dist.toStringAsFixed(3)}m -> Total Dist: ${totalDist.toStringAsFixed(3)}m -> Prod (x4): ${production.toStringAsFixed(3)} -> Integer Prod (UI): ${production.toInt()}');
  }
}

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
  final features = data['features'];
  final calc = CoordinateService();
  
  int totalOriginalPoints = 0;
  int removedPoints50 = 0;
  int removedPoints100 = 0;
  
  for (var feature in features) {
     final geom = feature['geometry'];
     final properties = feature['properties'];
     final id = properties != null ? (properties['OBJECTID_1'] ?? properties['OBJECTID']) : 'Unknown';
     
     if (geom['type'] == 'MultiLineString') {
         final lines = geom['coordinates'] as List<dynamic>;
         
         List<List<Position>> subLines = [];
         for (var line in lines) {
             List<Position> currentLine = [];
             for(var point in line) {
                if (point is List && point.length >= 2) {
                   currentLine.add(Position((point[0] as num).toDouble(), (point[1] as num).toDouble()));
                }
             }
             if (currentLine.isNotEmpty) subLines.add(currentLine);
         }
         
         if (subLines.isEmpty) continue;
         
         List<Position> stitchedPath = [];
         stitchedPath.addAll(subLines.first);
         subLines.removeAt(0);

         while (subLines.isNotEmpty) {
             final tail = stitchedPath.last;
             final head = stitchedPath.first;
             
             double bestDist = double.infinity;
             int bestIndex = -1;
             bool reverseBest = false;
             bool connectToHead = false;

             for (int i = 0; i < subLines.length; i++) {
                 final candidateHead = subLines[i].first;
                 final candidateTail = subLines[i].last;

                 final distTailToHead = calc.getDistance(tail, candidateHead);
                 final distTailToTail = calc.getDistance(tail, candidateTail);
                 final distHeadToTail = calc.getDistance(head, candidateTail);
                 final distHeadToHead = calc.getDistance(head, candidateHead);
                 
                 final minCandidateDist = [distTailToHead, distTailToTail, distHeadToTail, distHeadToHead].reduce(min);
                 
                 if (minCandidateDist < bestDist) {
                     bestDist = minCandidateDist;
                     bestIndex = i;
                     if (bestDist == distTailToHead) {
                         reverseBest = false;
                         connectToHead = false;
                     } else if (bestDist == distTailToTail) {
                         reverseBest = true;
                         connectToHead = false;
                     } else if (bestDist == distHeadToTail) {
                         reverseBest = false;
                         connectToHead = true;
                     } else if (bestDist == distHeadToHead) {
                         reverseBest = true;
                         connectToHead = true;
                     }
                 }
             }

             if (bestIndex != -1) {
                 var chosenLine = subLines[bestIndex];
                 if (reverseBest) {
                     chosenLine = chosenLine.reversed.toList();
                 }
                 if (connectToHead) {
                     stitchedPath.insertAll(0, chosenLine);
                 } else {
                     stitchedPath.addAll(chosenLine);
                 }
                 subLines.removeAt(bestIndex);
             } else {
                 break; 
             }
         }
         
         totalOriginalPoints += stitchedPath.length;
         
         for (int i = 1; i < stitchedPath.length; i++) {
             final prev = stitchedPath[i-1];
             final current = stitchedPath[i];
             final dist = calc.getDistance(prev, current);
             
             if (dist > 50.0) removedPoints50++;
             if (dist > 100.0) removedPoints100++;
         }
     }
  }
  
  print('Total Points: $totalOriginalPoints');
  print('Number of line breaks (>50m): $removedPoints50');
  print('Number of line breaks (>100m): $removedPoints100');
}

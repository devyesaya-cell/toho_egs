import 'dart:convert';
import 'dart:io';

void main() async {
  final file = File('docs/RSKA082A01_Line_Sample_geo_simplify10cm_pr_gjson.geojson');
  final String content = await file.readAsString();
  final Map<String, dynamic> data = json.decode(content);

  if (data['type'] == 'FeatureCollection' && data['features'] != null) {
    final List<dynamic> features = data['features'];
    
    Set<int> uniqueObjectIds = {};
    Set<int> uniqueObjectId1s = {};
    
    int objectIdCount = 0;
    int objectId1Count = 0;
    int missingObjectId = 0;
    
    for (var feature in features) {
      final properties = feature['properties'];
      if (properties != null) {
        if (properties['OBJECTID'] != null) {
          objectIdCount++;
          uniqueObjectIds.add(properties['OBJECTID'] as int);
        } else {
            missingObjectId++;
        }
        
        if (properties['OBJECTID_1'] != null) {
          objectId1Count++;
          uniqueObjectId1s.add(properties['OBJECTID_1'] as int);
        }
      }
    }
    
    print('Total features: ${features.length}');
    print('OBJECTID count: $objectIdCount, Unique: ${uniqueObjectIds.length}');
    print('OBJECTID_1 count: $objectId1Count, Unique: ${uniqueObjectId1s.length}');
    print('Missing OBJECTID: $missingObjectId');
  }
}

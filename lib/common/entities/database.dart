class ZoneEntity {
  int? id;
  String name;

  ZoneEntity({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory ZoneEntity.fromMap(Map<String,dynamic>json)=>ZoneEntity(name:json["name"],id:json["id"]);
}

class DivisionEntity {
  int? id;
  String name;
  int? zoneId;

  DivisionEntity({this.id, required this.name, this.zoneId});

  Map<String, dynamic> toMap() {
    return {'name': name, 'zoneId': zoneId};
  }

  factory DivisionEntity.fromMap(Map<String,dynamic>json)=>DivisionEntity(name: json["name"], zoneId:json["zoneId"],id: json["id"]);
}

class SectionEntity {
  int? id;
  String name;
  int? divisionId;

  SectionEntity({this.id, required this.name, this.divisionId});

  Map<String, dynamic> toMap() {
    return {'name': name, 'divisionId': divisionId};
  }

  factory SectionEntity.fromMap(Map<String,dynamic>json)=>SectionEntity(name: json["name"], divisionId: json["divisionId"],id: json["id"]);
}

class DataEntity{
  double? gauge;
  double? level;
  double? gradient;
  double? temp;
  int? speed;
  double? twist;
  double? longitude;
  double? latitude;
  DataEntity({this.gauge,this.gradient,this.level,this.speed,this.temp,this.twist,this.longitude,this.latitude});

}

class RecordingEntity {
  int? id;
  String? name;
  String? zone;
  String? section;
  String? division;
  String? operator;
  String? date_time;
  String? direction;

  RecordingEntity({this.name, this.zone, this.division, this.section, this.operator,this.date_time , this.id,this.direction});

  // Static method to create a RecordingEntity object from a map

  factory RecordingEntity.fromMap(Map<String,dynamic>map)=>RecordingEntity(
      id: map["id"],
      name: map['name'],
      zone: map['zone'],
      section: map['section'],
      division: map['division'],
      operator: map['operator'],
      date_time: map["dateTime"],
      direction: map["direction"]
  );

}



class RecordingDataEntity{
  int? id;
  String? recording_name;
  String? gauge;
  String? level;
  String?  gradient;
  String? temp;
  String? distance;
  String? twist;
  String? longitude;
  String? latitude;
  String? relative_distance;
  String? actual_distance;
  String? date_time = DateTime.now().toString();
  RecordingDataEntity({this.recording_name,this.gauge,this.level,this.gradient,this.temp,this.distance,this.twist,this.longitude,this.latitude,this.id,this.date_time,this.actual_distance,this.relative_distance});


  factory RecordingDataEntity.fromMap(Map<String,dynamic>map)=>RecordingDataEntity(
    id:map["id"],
  recording_name:map["recording_name"] ,
    gauge: map["gauge"],
    level: map["level"],
    gradient:map["gradient"] ,
    temp: map["temp"],
    distance: map["speed"],
    twist: map["twist"],
    longitude: map["longitude"],
    latitude: map["latitude"],
    date_time: "${DateTime.parse(map["dateTime"]).day}-${DateTime.parse(map["dateTime"]).month}-${DateTime.parse(map["dateTime"]).year}   ${DateTime.parse(map["dateTime"]).hour}:${DateTime.parse(map["dateTime"]).minute}:${DateTime.parse(map["dateTime"]).second}",
    relative_distance:  map["relative_distance"].toString(),
    actual_distance: map["actual_distance"].toString(),
  );

}
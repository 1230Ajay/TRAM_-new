class LocationEntity{
  String? zone;
  String? division;
  String? section;

  LocationEntity({this.zone,this.section,this.division});

  Map<String,dynamic> toJson()=>{
    "zone":zone,
    "division":division,
    "section":section
  };

  factory LocationEntity.fromMap(Map<String,dynamic>json)=>LocationEntity(zone:json["zone"],division:json["division"],section: json["section"]);

}
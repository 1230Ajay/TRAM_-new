class LoginRequestEntity{
  String? email;

  LoginRequestEntity({this.email});

  Map<String,dynamic> toJson()=>{"email":email};
}


class LoginResponeEntity{
  String? name;
  String? email;
  String? designation;
  String? mobile;
  String? zone;
  String? div;
  String? sec;

  LoginResponeEntity({this.email,this.zone,this.designation,this.mobile,this.div,this.sec,this.name});

  factory LoginResponeEntity.fromJson({required Map<String,dynamic> data}) =>LoginResponeEntity(
    name: "${data["first_name"]} ${data["last_name"]}",
  email: data["email"],
    designation: data["designation"],
    mobile: data["mobile"],
    zone: data[""],
    div: data[""],
    sec: data[""]
  );
}
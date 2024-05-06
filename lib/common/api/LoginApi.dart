

import '../entities/login.dart';
import '../utils/httputils.dart';

class LoginApi {
  static Future<LoginResponeEntity?> login(
      {required LoginRequestEntity entity}) async {


    var res = await HttpUtil().post(
        relativePath: "/getuserlogin", data: entity.toJson());
    List<dynamic> data = res["data"];
    if (data.isNotEmpty) {
        var locations = await HttpUtil().get(path: "//domain/section");
        List lcs = locations["data"];
        Map<String,dynamic> location={};

       lcs.forEach((element) {if(element["section_name"]==res["data"][0]["section"]){
         print(element);
         location=element;
       }});

     if(location!=null){
       LoginResponeEntity locationRes = LoginResponeEntity.fromJson(data: res["data"][0]);
       locationRes.sec = location["section_code"];
       locationRes.div = location["division_code"];
       locationRes.zone = location["zone_code"];
       return locationRes;
     }
    } else {
      return null;
    }
  }


}
import 'package:shared_preferences/shared_preferences.dart';

import '../values/constants.dart';


class StorageService {
  late final SharedPreferences _sharedPreferences;

  Future<StorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool({required String key, required bool value}) async {
    return await _sharedPreferences.setBool(key, value);
  }

  Future<bool> setString({required String key, required String value}) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<bool> remove({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  Future<String> getTolerance() async {
    return await _sharedPreferences.getString(AppConstants.TOLERANCE) ?? '';
  }

  Future<String> getCalibration() async {
    return await _sharedPreferences.getString(AppConstants.CALIBRATION) ?? '';
  }

  Future<bool> getIsDataBaseExist() async {
    return await _sharedPreferences.getBool(AppConstants.IS_DATA_BASE_EXISTS) ??
        false;
  }

  Future<String> getLocationData() async {
    return await _sharedPreferences.getString(AppConstants.lOCATION) ?? "";
  }

  Future<bool> setComPort({required String value}) async {
    return await _sharedPreferences.setString(AppConstants.COM_PORT, value);
  }

  Future<bool> setBuadrate({required String value}) async {
    return await _sharedPreferences.setString(AppConstants.BAUDRATE, value);
  }

  String getComPort() {
    return _sharedPreferences.getString(AppConstants.COM_PORT) ?? "COM3";
  }

  String getBaudrate() {
    return _sharedPreferences.getString(AppConstants.BAUDRATE) ?? "115200";
  }

  Future<bool> setEmail({required String value}) {
    return _sharedPreferences.setString(AppConstants.EMAIL, value);
  }

  Future<bool> setDesignation({required String value}) {
    return _sharedPreferences.setString(AppConstants.PASSWORD, value);
  }

  Future<bool> setOperatorName({required String value}) {
    return _sharedPreferences.setString(AppConstants.OPRATORNAME, value);
  }

  Future<bool> setMobile({required String value}) {
    return _sharedPreferences.setString(AppConstants.MOBILE, value);
  }

  Future<bool> setDiv({required String value}) {
    return _sharedPreferences.setString(AppConstants.DIV, value);
  }

  Future<bool> setSec({required String value}) {
    return _sharedPreferences.setString(AppConstants.SEC, value);
  }

  Future<bool> setZone({required String value}) {
    return _sharedPreferences.setString(AppConstants.ZONE, value);
  }

  Future<bool> setPassword({required String value}) {
    return _sharedPreferences.setString(AppConstants.PASSWORD, value);
  }

  String getEmail() {
    return _sharedPreferences.getString(AppConstants.EMAIL) ?? "";
  }

  String getPassowrd() {
    return _sharedPreferences.getString(AppConstants.PASSWORD) ?? "";
  }

  String getOperatorName() {
    return _sharedPreferences.getString(AppConstants.OPRATORNAME) ?? "";
  }

  String getDesignatiton() {
    return _sharedPreferences.getString(AppConstants.PASSWORD) ?? "";
  }

  String getMobile() {
    return _sharedPreferences.getString(AppConstants.MOBILE) ?? "";
  }

  String getDiv() {
    return _sharedPreferences.getString(AppConstants.DIV) ?? "";
  }

  String getSec() {
    return _sharedPreferences.getString(AppConstants.SEC) ?? "";
  }

  String getZone() {
    return _sharedPreferences.getString(AppConstants.ZONE) ?? "";
  }

  Future<bool> setUnit(String value)async{
    return await _sharedPreferences.setString(AppConstants.UNIT, value);
  }

  Future<bool> setDistance(double value)async{
    return await _sharedPreferences.setDouble(AppConstants.DISTANCE, value);
  }

  String getUnit() {
    return _sharedPreferences.getString(AppConstants.UNIT) ?? "";
  }

 double  getDistance() {
    return _sharedPreferences.getDouble(AppConstants.DISTANCE) ?? 1;
  }
}

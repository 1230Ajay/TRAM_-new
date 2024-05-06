

import 'common/helper/database_helper.dart';
import 'common/services/storage_service.dart';

class Global {
  static late StorageService storageService;
  static late DatabaseHelper dataBaseService;

  static Future<void> init() async {
    storageService = await StorageService().init();
    dataBaseService = DatabaseHelper();
  }
}

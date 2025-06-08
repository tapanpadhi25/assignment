import 'dart:convert';
import 'package:assignment/constants/api_url.dart';
import 'package:assignment/model/notification_model.dart';
import 'package:assignment/utils/global_utils.dart';

class NotificationServices {
  NotificationServices.init();
  static final NotificationServices i = NotificationServices.init();

  Future<NotificationModel?> getNotification() async {
    final api = URLS.base + URLS.notification;
    print("API: $api");
    try {
      final response = await getDio().get(api);
      if (response.statusCode == 200) {
        final decoded = response.data is String ? jsonDecode(response.data) : response.data;
        return NotificationModel.fromJson(decoded);
      }
    } catch (e) {
      print("Service Error: $e");
    }
    return null;
  }
}

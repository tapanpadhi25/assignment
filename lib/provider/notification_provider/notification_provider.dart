import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assignment/services/notification_services.dart';
import 'package:assignment/provider/notification_provider/notification_notifier.dart';
import 'package:assignment/model/notification_model.dart';

final notificationProvider = ChangeNotifierProvider((ref) => NotificationState());

final allNotification = FutureProvider.family.autoDispose<List<NotificationModelData>?, String>((ref, _) async {
  final notificationState = ref.watch(notificationProvider);
  try {
    final response = await NotificationServices.i.getNotification();
    if (response != null && response.message != null) {
      notificationState.setIsLoading(false);
      notificationState.setNotificationData(response.data!);
      return response.data;
    }
  } catch (e) {
    print("provider error: $e");
  }
  notificationState.setIsLoading(false);
  return null;
});

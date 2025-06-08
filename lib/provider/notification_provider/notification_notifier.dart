import 'package:assignment/model/notification_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationState extends ChangeNotifier{
bool _isLoading = false;
List<NotificationModelData> _notificationList = [];

bool get isLoading => _isLoading;
List<NotificationModelData> get notificationList => _notificationList;

void setIsLoading(bool loading){
  _isLoading = loading;
  notifyListeners();
}
void setNotificationData(List<NotificationModelData> data){
  _notificationList = data;
  notifyListeners();
}

}
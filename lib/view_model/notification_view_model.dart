import 'package:flutter/foundation.dart';

import '../data/model/notification_model.dart';

class NotificationViewModel extends ChangeNotifier {
  List<NotificationModel> notifications = [];

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
    notifyListeners();
  }

  List<NotificationModel> getNotifications() {
    return notifications;

  }

  void deleteNotificationById(int id) {
    notifications.removeWhere((notification) => notification.id == id);
    notifyListeners();
  }

  void deleteAllNotifications() {
    notifications=[];
    notifyListeners();

  }

}

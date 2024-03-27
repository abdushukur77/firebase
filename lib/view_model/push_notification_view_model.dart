import 'package:flutter/foundation.dart';

import '../data/model/notification_model.dart';
import '../data/model/push_notification_model.dart';

class PushNotificationViewModel extends ChangeNotifier {
  List<PushNotificationModel> pushNotifications = [];

  void addNotification(PushNotificationModel pushNotificationModel) {
    pushNotifications.add(pushNotificationModel);
    notifyListeners();
  }

  List<PushNotificationModel> getNotifications() {
    return pushNotifications;

  }

  void deleteNotificationById(int id) {
    pushNotifications.removeWhere((pushNotificationModel) => pushNotificationModel.id == id);
    notifyListeners();
  }

  void deleteAllNotifications() {
    pushNotifications=[];
    notifyListeners();

  }

}

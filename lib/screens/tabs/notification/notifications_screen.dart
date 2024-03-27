// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
//
// import '../../../services/local_notification_service.dart';
// import '../../../utils/colors/app_colors.dart';
// import '../../../utils/styles/app_text_style.dart';
// import '../../../view_model/notification_view_model.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     final notificationViewModel = Provider.of<NotificationViewModel>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Notifications",
//           style: AppTextStyle.interSemiBold.copyWith(color: AppColors.black),
//         ),
//         backgroundColor: AppColors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             children: [
//               for (var notification in notificationViewModel.getNotifications())
//                 ListTile(
//                   // leading: Text(notification.id.toString(), style: AppTextStyle.rubikMedium.copyWith(color: Colors.black, fontSize: 24),),
//                   title: Text(notification.name,
//                       style: AppTextStyle.interMedium
//                           .copyWith(color: Colors.black, fontSize: 18)),
//                   trailing: IconButton(
//                     onPressed: () {
//                       LocalNotificationService()
//                           .cancelNotification(notification.id);
//                       context
//                           .read<NotificationViewModel>()
//                           .deleteNotificationById(notification.id);
//                     },
//                     icon: Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ),
//               Visibility(
//                 visible: notificationViewModel.getNotifications().isNotEmpty,
//                 child: TextButton(
//                     style: TextButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                             vertical: 16.h, horizontal: 40.w),
//                         backgroundColor: AppColors.c06070D,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15))),
//                     onPressed: () {
//                       LocalNotificationService().cancelAll();
//                       context
//                           .read<NotificationViewModel>()
//                           .deleteAllNotifications();
//                     },
//                     child: Center(child: Text("CLEAR ALL", style: AppTextStyle.interSemiBold.copyWith(color: Colors.white),))),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../services/local_notification_service.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_text_style.dart';
import '../../../view_model/notification_view_model.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final notificationViewModel = Provider.of<NotificationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Push Notifications",
          style: AppTextStyle.interSemiBold.copyWith(color: AppColors.black),
        ),
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              for (var notification in notificationViewModel.getNotifications())
                ListTile(
                  // leading: Text(notification.id.toString(), style: AppTextStyle.rubikMedium.copyWith(color: Colors.black, fontSize: 24),),
                  title: Text(notification.name,
                      style: AppTextStyle.interMedium
                          .copyWith(color: Colors.black, fontSize: 18)),
                  trailing: IconButton(
                    onPressed: () {
                      LocalNotificationService()
                          .cancelNotification(notification.id);
                      context
                          .read<NotificationViewModel>()
                          .deleteNotificationById(notification.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              Visibility(
                visible: notificationViewModel.getNotifications().isNotEmpty,
                child: TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 40.w),
                        backgroundColor: AppColors.c06070D,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      LocalNotificationService().cancelAll();
                      context
                          .read<NotificationViewModel>()
                          .deleteAllNotifications();
                    },
                    child: Center(child: Text("CLEAR ALL", style: AppTextStyle.interSemiBold.copyWith(color: Colors.white),))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

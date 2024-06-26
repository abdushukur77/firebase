import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/screens/add_pruduct.dart';
import 'package:library_app/services/local_notification_service.dart';

import 'package:provider/provider.dart';

import '../../../data/api_provider/api_provider.dart';
import '../../../data/model/notification_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/push_notification_model.dart';
import '../../../main.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../view_model/notification_view_model.dart';
import '../../../view_model/product_view_model.dart';
import '../../../view_model/push_notification_view_model.dart';
import '../detail_screen.dart';
import 'product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String fcmToken = "";

  void init() async {
    fcmToken = await FirebaseMessaging.instance.getToken() ?? "";
    debugPrint("FCM TOKEN:$fcmToken");
    final token = await FirebaseMessaging.instance.getAPNSToken();
    debugPrint("getAPNSToken : ${token.toString()}");
    LocalNotificationService.localNotificationService;
    //Foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        if (remoteMessage.notification != null) {
          LocalNotificationService().showNotification(
            title: remoteMessage.notification!.title!,
            body: remoteMessage.notification!.body!,
            id: DateTime.now().second.toInt(),
          );

          debugPrint(
              "FOREGROUND NOTIFICATION:${remoteMessage.notification!.title}");
        }
      },
    );
    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      debugPrint("ON MESSAGE OPENED APP:${remoteMessage.notification!.title}");
    });
    // Terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint("TERMINATED:${message.notification?.title}");
      }
    });
  }

  // _init() async {
  //
  //
  //   String? fcmToken = await FirebaseMessaging.instance.getToken();
  //   debugPrint("Tokeeeennnnnn ${fcmToken}");
  //   FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) {
  //
  //     if (remoteMessage.notification != null) {
  //       LocalNotificationService().showNotification(
  //         title: remoteMessage.notification!.title!,
  //         body: remoteMessage.notification!.body!,
  //         id: remoteMessage.notification!.hashCode,
  //       );
  //     }
  //   });
  // }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(color: AppColors.c_2C2C73),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddProduct();
              }));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductViewModel>().listenProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<ProductModel> list = snapshot.data as List<ProductModel>;
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding:  EdgeInsets.all(25.w),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    children: [
                      ...List.generate(list.length, (index) {
                        ProductModel productModel = list[index];
                        // ProductModel productModel =
                        // context.watch<ProductViewModel>().categoryProduct[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(20.w),
                          onTap: () {
                            debugPrint(productModel.productName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailScreen(
                                    productModel1: productModel,
                                  );
                                },
                              ),
                            );
                          },
                          child: ProductsItem(
                            docId: '',
                            productName: productModel.productName,
                            productDescription: productModel.productDescription,
                            price: productModel.price,
                            imageUrl: productModel.imageUrl.toString(),
                            categoryId: '',
                          ),
                        );
                      })
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

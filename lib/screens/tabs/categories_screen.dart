import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../utils/colors/app_colors.dart';
import '../../data/api_provider/api_provider.dart';
import '../../data/model/category_model.dart';
import '../../data/model/notification_model.dart';
import '../../data/model/push_notification_model.dart';
import '../../services/local_notification_service.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_model/category_view_model.dart';
import '../../view_model/image_view_model.dart';
import '../../view_model/notification_view_model.dart';
import '../../view_model/push_notification_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ImagePicker picker = ImagePicker();

  String imageUrl = "";
  String storagePath = "";

  @override
  Widget build(BuildContext context) {
    String categoriesName = "";
    String imageURL = "";
    String docId = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Categories",
          style: TextStyle(
            color: AppColors.c_2C2C73,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 25.w,
        ),
        child: StreamBuilder<List<CategoryModel>>(
          stream: context.read<CategoryViewModel>().listenCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              List<CategoryModel> list = snapshot.data as List<CategoryModel>;
              return ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                    'Add Category',
                                    style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 18.w,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Column(
                                      children: [
                                        TextField(
                                          style: TextStyle(color: Colors.black),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (v) {
                                            categoriesName = v;
                                          },
                                          decoration: InputDecoration(
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintMaxLines: 4,
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 14),
                                              hintText: "Categories Name",
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                  borderRadius: BorderRadius.circular(
                                                      12)),
                                              disabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(12))),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(height: 24.h),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.all(24),
                                            backgroundColor: AppColors.c06070D,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                          ),
                                          onPressed: () {
                                            takeAnImage();
                                          },
                                          child: Text(
                                            "Upload your image",
                                            style: AppTextStyle.interSemiBold
                                                .copyWith(
                                              fontSize: 24,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        if (context
                                            .watch<ImageViewModel>()
                                            .getLoader)
                                          const CircularProgressIndicator(),
                                        if (imageUrl.isNotEmpty)
                                          Image.network(imageUrl),

                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.w),
                                            color: AppColors.c_2C2C73,
                                          ),
                                          child: Row(
                                            children: [
                                              Spacer(),
                                              IconButton(
                                                onPressed: ()
                                                async {
                                                  if (imageUrl.isNotEmpty &&
                                                      categoriesName.isNotEmpty) {
                                                    await context.read<CategoryViewModel>().insertCategory(
                                                      CategoryModel(
                                                        storagePath: storagePath,
                                                        imageUrl: imageUrl,
                                                        categoryName: categoriesName,
                                                        docId: "",
                                                      ),
                                                      context,
                                                    );
                                                    Navigator.pop(context);

                                                  }
                                                },

                                                // {
                                                //   context
                                                //       .read<CategoryViewModel>()
                                                //       .updateCategory(
                                                //         CategoryModel(
                                                //           imageUrl:
                                                //               "https://dnr.wisconsin.gov/sites/default/files/feature-images/ECycle_Promotion_Manufacturers.jpg",
                                                //           categoryName: "Electronics",
                                                //           docId: category.docId,
                                                //         ),
                                                //         context,
                                                //       );
                                                // },
                                                icon: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              // IconButton(
                                              //   onPressed: () async {
                                              //     context
                                              //         .read<CategoryViewModel>()
                                              //         .insertCategory(
                                              //           CategoryModel(
                                              //             imageUrl: imageURL,
                                              //             categoryName:
                                              //                 categoriesName,
                                              //             docId: docId,
                                              //           ),
                                              //           context,
                                              //         );
                                              //     // NotificationModel notification = NotificationModel(
                                              //     //     name: "Kategoriya muvaffaqiyatli qoshildi!",
                                              //     //     id: DateTime.now().millisecond
                                              //     // );
                                              //     // context.read<NotificationViewModel>().addNotification(notification);
                                              //     //
                                              //     // LocalNotificationService().showNotification(
                                              //     //   title: notification.name,
                                              //     //   body: "Kategoriya muvaffaqiyatli qoshildi",
                                              //     //   id: notification.id,
                                              //     // );
                                              //     String messageId =
                                              //         await ApiProvider()
                                              //             .sendNotificationToUsers(
                                              //       title:
                                              //           "Kategoriya muvaffaqiyatli qoshildi",
                                              //       body:
                                              //           "Kategoriya muvaffaqiyatli qoshildi",
                                              //     );
                                              //     debugPrint(
                                              //         "MESSAGE ID:$messageId");
                                              //
                                              //     PushNotificationModel
                                              //         notification =
                                              //         PushNotificationModel(
                                              //             name:
                                              //                 "Kategoriya muvaffaqiyatli qoshildi!",
                                              //             id: DateTime.now()
                                              //                 .millisecond);
                                              //     context
                                              //         .read<
                                              //             PushNotificationViewModel>()
                                              //         .addNotification(
                                              //             notification);
                                              //
                                              //     Navigator.pop(context);
                                              //   },
                                              //   icon: const Icon(
                                              //     Icons.add,
                                              //     color: Colors.white,
                                              //   ),
                                              // ),
                                              // SizedBox(
                                              //   width: 5.w,
                                              // ),
                                              // const Text("Add Categories",
                                              //     style: TextStyle(
                                              //         color: Colors.white)),

                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                  ...List.generate(
                    list.length,
                    (index) {
                      CategoryModel category = list[index];
                      return ZoomTapAnimation(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.w),
                                color: Colors.white,
                                border: Border.all(
                                    width: 1, color: AppColors.c_2C2C73)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15.w),
                                      child: Image.network(
                                        category.imageUrl,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          category.categoryName,
                                          style: const TextStyle(
                                            color: AppColors.c_2C2C73,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Text(
                                          category.docId,
                                          style: TextStyle(
                                              color: AppColors.c_2C2C73),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.w),
                                        color: AppColors.c_2C2C73,
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<CategoryViewModel>()
                                              .deleteCategory(
                                                  category.docId, context);
                                          NotificationModel notification =
                                              NotificationModel(
                                                  name:
                                                      "Kategoriya muvaffaqiyatli o'chirildi!",
                                                  id: DateTime.now()
                                                      .millisecond);
                                          context
                                              .read<NotificationViewModel>()
                                              .addNotification(notification);

                                          LocalNotificationService()
                                              .showNotification(
                                            title: notification.name,
                                            body:
                                                "Kategoriya muvaffaqiyatli o'chirildi",
                                            id: notification.id,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 145.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.w),
                                        color: AppColors.c_2C2C73,
                                      ),
                                      child: IconButton(
                                        onPressed: ()
                                        async {
                                          if (imageUrl.isNotEmpty &&
                                              categoriesName.isNotEmpty) {
                                            await context.read<CategoryViewModel>().insertCategory(
                                              CategoryModel(
                                                storagePath: storagePath,
                                                imageUrl: imageUrl,
                                                categoryName: categoriesName,
                                                docId: "",
                                              ),
                                              context,
                                            );

                                            Navigator.pop(context);
                                          }
                                        },

                                        // {
                                        //   context
                                        //       .read<CategoryViewModel>()
                                        //       .updateCategory(
                                        //         CategoryModel(
                                        //           imageUrl:
                                        //               "https://dnr.wisconsin.gov/sites/default/files/feature-images/ECycle_Promotion_Manufacturers.jpg",
                                        //           categoryName: "Electronics",
                                        //           docId: category.docId,
                                        //         ),
                                        //         context,
                                        //       );
                                        // },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
            pickedFile: image,
            storagePath: storagePath,
          );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
            pickedFile: image,
            storagePath: storagePath,
          );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h),
            ],
          );
        });
  }
}

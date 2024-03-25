import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../utils/colors/app_colors.dart';
import '../../data/model/category_model.dart';
import '../../view_model/category_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    String categoriesName = "";
    String imageURL = "";
    String docId = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories",style: TextStyle(color: AppColors.c_2C2C73,),),

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
                    children: [IconButton(onPressed: (){

                      showDialog(context: context, builder: (BuildContext context) {
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
                           Column(children: [
                             TextField(
                               style: TextStyle(color: Colors.black),
                               textInputAction: TextInputAction.next,
                               onChanged: (v) {
                                 categoriesName = v;
                               },
                               decoration: InputDecoration(
                                   floatingLabelBehavior: FloatingLabelBehavior.always,
                                   fillColor: Colors.white,
                                   filled: true,
                                   hintMaxLines: 4,
                                   contentPadding:
                                   EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                   hintText: "Categories Name",
                                   hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                                   enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.black),
                                       borderRadius: BorderRadius.circular(12)),
                                   disabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.black),
                                       borderRadius: BorderRadius.circular(12)),
                                   focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: AppColors.black),
                                       borderRadius: BorderRadius.circular(12))),
                             ),
                             SizedBox(
                               height: 10.h,
                             ),
                             TextField(
                               style: TextStyle(color: Colors.black),
                               textInputAction: TextInputAction.next,
                               onChanged: (v) {
                                 imageURL = v;
                               },
                               decoration: InputDecoration(
                                   floatingLabelBehavior: FloatingLabelBehavior.always,
                                   fillColor: Colors.white,
                                   filled: true,
                                   hintMaxLines: 4,
                                   contentPadding:
                                   EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                   hintText: "Image Url",
                                   hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                                   enabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.black),
                                       borderRadius: BorderRadius.circular(12)),
                                   disabledBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: Colors.black),
                                       borderRadius: BorderRadius.circular(12)),
                                   focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: AppColors.black),
                                       borderRadius: BorderRadius.circular(12))),
                             ),
                             SizedBox(
                               height: 10.h,
                             ),
                             TextField(
                               style: TextStyle(color: Colors.black),
                               textInputAction: TextInputAction.next,
                               onChanged: (v) {
                                 docId = v;
                               },
                               decoration: InputDecoration(
                                   floatingLabelBehavior: FloatingLabelBehavior.always,
                                   fillColor: Colors.white,
                                   filled: true,
                                   hintMaxLines: 4,
                                   contentPadding:
                                   EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                   hintText: "Doc ID",
                                   hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
                                   enabledBorder: OutlineInputBorder(
                                       borderSide: const BorderSide(color: Colors.black),
                                       borderRadius: BorderRadius.circular(12)),
                                   disabledBorder: OutlineInputBorder(
                                       borderSide: const BorderSide(color: Colors.black),
                                       borderRadius: BorderRadius.circular(12)),
                                   focusedBorder: OutlineInputBorder(
                                       borderSide: BorderSide(color: AppColors.black),
                                       borderRadius: BorderRadius.circular(12))),
                             ),
                             SizedBox(
                               height: 10.h,
                             ),
                             Container(
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15.w),
                                 color: AppColors.c_2C2C73,
                               ),
                               child: Row(
                                 children: [
                                   Spacer(),
                                   IconButton(
                                     onPressed: () {
                                       context.read<CategoryViewModel>().insertCategory(
                                         CategoryModel(
                                           imageUrl: imageURL,
                                           categoryName: categoriesName,
                                           docId: docId,
                                         ),
                                         context,
                                       );
                                       Navigator.pop(context);
                                     },
                                     icon: const Icon(
                                       Icons.add,
                                       color: Colors.white,
                                     ),
                                   ),
                                   SizedBox(
                                     width: 5.w,
                                   ),
                                   const Text(
                                     "Add Categories",
                                     style: TextStyle(color: Colors.white),
                                   ),
                                   Spacer(),
                                 ],
                               ),
                             ),

                             SizedBox(
                               height: 15.h,
                             ),

    ],)
                          ],
                        );
                      },);},
                     icon: Icon(Icons.add))],
                  ),

                  ...List.generate(
                    list.length,
                        (index) {
                      CategoryModel category = list[index];
                      return ZoomTapAnimation(
                          onTap: (){},
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: TextStyle(color: AppColors.c_2C2C73),
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
                                    borderRadius: BorderRadius.circular(15.w),
                                    color: AppColors.c_2C2C73,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<CategoryViewModel>()
                                          .deleteCategory(
                                          category.docId, context);
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
                                    borderRadius: BorderRadius.circular(15.w),
                                    color: AppColors.c_2C2C73,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<CategoryViewModel>()
                                          .updateCategory(
                                        CategoryModel(
                                          imageUrl:
                                          "https://dnr.wisconsin.gov/sites/default/files/feature-images/ECycle_Promotion_Manufacturers.jpg",
                                          categoryName: "Electronics",
                                          docId: category.docId,
                                        ),
                                        context,
                                      );
                                    },
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
}

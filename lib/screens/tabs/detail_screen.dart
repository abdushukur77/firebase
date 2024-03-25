import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../utils/colors/app_colors.dart';
import '../../data/model/product_model.dart';
import '../../utils/styles/app_text_style.dart';
import '../../view_model/product_view_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productModel1});

  final ProductModel productModel1;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.c_F9F9F9,
        appBar: AppBar(
          backgroundColor: AppColors.c_2C2C73,
          title: Center(
              child: Text(
            "Mahsulot malumotlari",
            style: TextStyle(color: Colors.black),
          )),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: SizedBox(
                              height: 300.h,
                              width: 200.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.w),
                                child: Image.network(
                                  widget.productModel1.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                child: const Text("Mahsulot nomi", maxLines: 1),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                width: 160,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    widget.productModel1.productName,
                                    maxLines: 1,
                                    style: AppTextStyle.interBold.copyWith(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                child: const Text("Tavsif"),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                width: 160,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    widget.productModel1.docId,
                                    style: AppTextStyle.interBold.copyWith(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                child: const Text("Narxi"),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                child: Row(
                                  children: [
                                    Text(
                                      "SUM ",
                                      style: TextStyle(
                                          fontSize: 19, color: Colors.blue),
                                    ),
                                    Text(
                                      widget.productModel1.price.toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    /**Manashu pekichni ishlatsak bolarkan**/

                    Center(
                      child: RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: const Text(
                        "Kitob haqida",
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(widget.productModel1.productDescription,
                          style: AppTextStyle.interSemiBold
                              .copyWith(color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      print("bosildi");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Ogoxlantrish!!!',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.w,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              'Ishonchingiz komilmi???',
                              style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 18.w,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            actions: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Yo'q"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      context
                                          .read<ProductViewModel>()
                                          .deleteProduct(
                                              widget.productModel1.docId,
                                              context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ha'),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(20.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w),
                        color: AppColors.c_2C2C73,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          Text(
                            " O'Chirish",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: 20.w,),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateBookScreen(bookModel: widget.bookModel)));
                    },
                    borderRadius: BorderRadius.circular(20.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w),
                        color: AppColors.c_2C2C73,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.update,
                            color: Colors.red,
                          ),
                          Text(
                            " O'zgartrish",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

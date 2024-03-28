import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/colors/app_colors.dart';

class ProductsItem extends StatelessWidget {
  const ProductsItem({
    super.key,
    required this.docId,
    required this.productName,
    required this.productDescription,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  final String docId;
  final String productName;
  final String productDescription;
  final double price;
  final String imageUrl;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.c_2C2C73),
        borderRadius: BorderRadius.circular(20.w),
        // color: Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SizedBox(
                height: 165.h,
                width: 150.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              productName,
              maxLines: 1,
              style: TextStyle(fontSize: 12.sp, color: AppColors.c_2C2C73),
            ),
          ),
          SizedBox(height: 5.w),
          SizedBox(height: 5.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                Text(
                  "SUM",
                  style: TextStyle(fontSize: 19.sp, color: Colors.blue),
                ),
                Text(price.toString(),
                    style: TextStyle(fontSize: 16.sp, color: AppColors.c_2C2C73)),

              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_app/utils/images/app_images.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/auth_view_model.dart';

class RegUserFormField extends StatelessWidget {
  const RegUserFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF262626),
      ),
      width: double.infinity,
      height: 41.h,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Ma'lumotni to'ldiring";
          }
          return null;
        },
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                color: Color(0xFF262626),
              )),
          labelText: "First Name",
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(AppImages.person),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/auth_view_model.dart';


class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF262626),
      width: double.infinity,
      height: 41,
      child: TextFormField(


        validator: (value) {
          if (value!.isEmpty) {
            return "Ma'lumotni to'ldiring";
          }
          return null;
        },
        controller: widget.controller,
        obscureText: isShow,
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
            labelText: "Password",
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/password.svg'),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isShow = !isShow;
                });
              },
              icon: Icon(
                  isShow ? Icons.hide_source_outlined : Icons.remove_red_eye),
            )),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:library_app/screens/auth/reg/widget/log_password_form_field.dart';
import 'package:library_app/screens/auth/reg/widget/reg_email_form_field.dart';
import 'package:library_app/screens/auth/reg/widget/reg_user_form_field.dart';
import 'package:provider/provider.dart';
import '../../../view_model/auth_view_model.dart';
import '../../routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController RegEmailController = TextEditingController();
  final TextEditingController RegUserController = TextEditingController();
  final TextEditingController RegPasswordController = TextEditingController();
  final _formKeyReg = GlobalKey<FormState>();
  bool isValue = false;


  @override
  void dispose() {
    RegEmailController.dispose();
    RegUserController.dispose();
    RegPasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFF000000),
        body: context.watch<AuthViewModel>().loading
            ? const Center(child: CircularProgressIndicator())
            :Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKeyReg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/main.png',
                  width: 280,
                  height: 255,
                ),
                const SizedBox(height: 10),
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                RegUserFormField(
                  controller: RegUserController,
                ),
                SizedBox(height: 10.h),

                RegEmailFormField(
                  controller: RegEmailController,
                ),
                SizedBox(height: 10.h),
                RegPasswordFormField(
                  controller: RegPasswordController,
                ),
                SizedBox(height: 15.h),
                const SizedBox(height: 25),
                Ink(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF262626),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        context.read<AuthViewModel>().registerUser(
                          context, email: RegEmailController.text,
                          password: RegPasswordController.text,
                          username: RegUserController.text);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.w),
                        child: const Center(
                          child: Text(
                            'SIGNUP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 13.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.loginRoute);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

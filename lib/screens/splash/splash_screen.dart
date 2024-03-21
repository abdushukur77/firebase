import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:library_app/screens/routes.dart';
import 'package:library_app/utils/size/size_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, RouteNames.loginRoute);

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacementNamed(context, RouteNames.loginRoute);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.shopping_cart,
          color: Colors.blue,
          size: 200,
        ),
      ),
    );
  }
}

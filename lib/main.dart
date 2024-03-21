import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/screens/routes.dart';
import 'package:library_app/screens/splash/splash_screen.dart';
import 'package:library_app/view_model/auth_view_model.dart';
import 'package:library_app/view_model/tab_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => TabViewModel()),
    ],
    child: ScreenUtilInit( // Wrap with ScreenUtilInit
      designSize: const Size(375, 812), // Set your design size
      builder: (context, child) => const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

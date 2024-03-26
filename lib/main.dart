import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/screens/routes.dart';
import 'package:library_app/screens/splash/splash_screen.dart';
import 'package:library_app/services/local_notification_service.dart';
import 'package:library_app/view_model/auth_view_model.dart';
import 'package:library_app/view_model/category_view_model.dart';
import 'package:library_app/view_model/product_view_model.dart';
import 'package:library_app/view_model/tab_view_model.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // LocalNotificationService().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => TabViewModel()),
      ChangeNotifierProvider(create: (_)=>CategoryViewModel()),
      ChangeNotifierProvider(create: (_)=>ProductViewModel())
    ],
    child: ScreenUtilInit( // Wrap with ScreenUtilInit
      designSize: const Size(375, 812), // Set your design size
      builder: (context, child) =>  MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    LocalNotificationService.localNotificationService.init(navigatorKey);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

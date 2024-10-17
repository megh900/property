

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newdoor/constants.dart';
import 'package:newdoor/preference/pref_utils.dart';
import 'package:newdoor/routes/app_route.dart';
import 'package:newdoor/services/notification_serive.dart';
import 'package:newdoor/theme.dart';
import 'dart:async';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.init();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: appTheme(),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}

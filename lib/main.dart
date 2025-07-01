import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/madels/firebase_options.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UzTravelProvider(),
      builder: (context, child) {
        return ScreenUtilInit(designSize: Size(360, 690), child: MaterialApp());
      },
    );
  }
}

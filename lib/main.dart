import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:uz_travel/madels/firebase_options.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/favorites_page.dart';
import 'package:uz_travel/views/home_page/home_page.dart';
import 'package:uz_travel/views/home_page/mainscaffold.dart';
import 'package:uz_travel/views/splash_page.dart';
import 'package:uz_travel/widgets/apptheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('uz'),
      ],
      path: 'assets/lang',
      fallbackLocale:  Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UzTravelProvider()..fetchPlaces(),
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Apptheme.lightTheme,
            darkTheme: Apptheme.darkTheme,
            themeMode: Provider.of<UzTravelProvider>(context).themeMode,

            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,

            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return  SplashPage();
                } else {
                  return  FavoritesPage();
                }
              },
            ),
          ),
        );
      },
    );
  }
}

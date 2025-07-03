import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:uz_travel/madels/firebase_options.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/home_page.dart';
import 'package:uz_travel/views/login/sign_up.dart';

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
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UzTravelProvider(),
      builder: (context, child) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SignUp();
                  } else {
                    return const HomePage();
                  }
                },
              ),
            );
          },
        );
      },
    );
  }
}

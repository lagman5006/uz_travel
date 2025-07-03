import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uz_travel/gen/assets.gen.dart';
import 'package:uz_travel/gen/fonts.gen.dart';
import 'package:uz_travel/views/onboarding_page.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  String selectedLang = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D6EFD),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              languageTile('UZ', Assets.images.uzb.path),
              SizedBox(width: 15.w),
              languageTile('RU', Assets.images.rus.path),
              SizedBox(width: 15.w),
              languageTile('EN', Assets.images.en.path),
            ],
          ),
        ),
      ),
    );
  }

  Widget languageTile(String lang, String imagePath) {
    bool isSelected = selectedLang == lang;

    return GestureDetector(
      onTap: () => selectLanguage(lang),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Til bayrog‘i yoki rasmi
          Image.asset(imagePath, width: 35.w, height: 30.h),
          SizedBox(height: 8.h),
          // Til kodi (UZ, RU, EN)
          Text(
            lang,
            style: TextStyle(
              fontSize: 25.sp,
              color: isSelected ? Colors.blue : Colors.white,
              fontFamily: FontFamily.gilroy,
            ),
          ),
          SizedBox(height: 10.h),
          // Dumaloq indikator
          Container(
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.blue : Colors.white,
              border: Border.all(color: Colors.blue, width: 2.w),
            ),
          ),
        ],
      ),
    );
  }

  void selectLanguage(String lang) {
    setState(() {
      selectedLang = lang;
    });

    // Tilga mos Locale ni belgilaymiz
    Locale newLocale;
    if (lang == 'UZ') {
      newLocale = const Locale('uz');
    } else if (lang == 'RU') {
      newLocale = const Locale('ru',);
    } else {
      newLocale = const Locale('en');
    }

    context.setLocale(newLocale);

    // Onboarding sahifasiga o‘tamiz
    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingPage()),
      );
    });
  }
}

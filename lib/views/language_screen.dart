import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uz_travel/gen/assets.gen.dart';
import 'package:uz_travel/gen/fonts.gen.dart';
import 'package:uz_travel/views/onboarding_page.dart';

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
      backgroundColor: Color(0xff0D6EFD),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              languageTile('UZ', Assets.images.pageImage1.path),
              SizedBox(width: 15.w),
              languageTile('RU', Assets.images.pageImage2.path),
              SizedBox(width: 15.w),
              languageTile('EN', Assets.images.pageImage3.path),
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
          // Rasm
          Image.asset(imagePath, width: 35.w, height: 30.h),
          SizedBox(height: 8.h),
          // Til nomi
          Text(
            lang,
            style: TextStyle(
              fontSize: 25.sp,
              color: isSelected ? Colors.blue : Colors.white,

              fontFamily: FontFamily.gilroy,
            ),
          ),
          SizedBox(height: 10.h),
          // Dumaloq belgisi
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

    Future.delayed(Duration(milliseconds: 100), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnboardingPage()),
      );
    });
  }
}

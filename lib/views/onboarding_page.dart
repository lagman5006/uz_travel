import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/gen/fonts.gen.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/login/sign_up.dart';
import 'package:easy_localization/easy_localization.dart';

class OnboardingPage extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UzTravelProvider>(
        builder: (context, provider, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 520.h,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            provider.updateIndex(index);
                          },
                          itemCount: provider.imagesPath.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.r),
                                    bottomRight: Radius.circular(20.r),
                                  ),
                                  child: Image.asset(
                                    provider.imagesPath[index],
                                    width: double.infinity,
                                    height: 300.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 40.h),
                                RichText(
                                  text: TextSpan(
                                    text: "life_is_short_and_the_world_is_wide"
                                        .tr(),
                                    style: TextStyle(
                                      fontFamily: FontFamily.geometr415BlkBT,
                                      fontSize: 25.sp,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "wide".tr(),
                                        style: TextStyle(
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 32.w,
                                  ),
                                  child: Text(
                                    "friends_tours_description".tr(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontFamily: FontFamily.gilroy,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Positioned(
                          top: 16.h,
                          right: 24.w,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: Text(
                              "skip",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(provider.imagesPath.length, (
                      index,
                    ) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        width: provider.currentIndex == index ? 20.w : 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: provider.currentIndex == index
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 30.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (provider.currentIndex <
                              provider.imagesPath.length - 1) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          provider.currentIndex == 0
                              ? "get_started"
                                    .tr() 
                              : "next".tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

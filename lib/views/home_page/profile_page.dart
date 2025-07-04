import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uz_travel/gen/assets.gen.dart';
import 'package:uz_travel/views/login/sign_in.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              // bu yerda SignIn ga otadigan qildim keyinchalik togirlanadi
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30.w),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Icon(Icons.keyboard_arrow_left),
            ),
          ),
        ),
        title: Center(
          child: Text(
            "Profile".tr(),
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Assets.svgs.edit.svg(width: 20.w, height: 20.h),
            onPressed: () {
              // Tahrirlash funksiyasi
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.transparent,
              child: Assets.svgs.man.svg(width: 80.w, height: 80.h),
            ),

            SizedBox(height: 10.h),
            Text(
              'Leonardo',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.h),
            Text(
              'leonardo@gmail.com',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),

            // Statistika containeri
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                color: Color(0xFFF7F7F9),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statColumn("Reward Points".tr(), "360"),
                  _divider(),
                  _statColumn("Travel Trips".tr(), "238"),
                  _divider(),
                  _statColumn("Bucket List".tr(), "473"),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 400.h,
              child: ListView(
                children: [
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.person),
                    title: Text("Profile".tr()),
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {
                      // funksiya yozsa boladi bosganda qayerga otishi
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.withOpacity(0.3),
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.bookmark),
                    title: Text('bookmarked'.tr()),
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {
                      // funksiya yozsa boladi bosganda qayerga otishi
                    },
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    thickness: 0.4,
                    color: Colors.grey.withOpacity(0.3),
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: Text("previous_trips".tr()),
                    leading: Assets.svgs.trip.svg(width: 80.w, height: 80.h),
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {
                      // funksiya yozsa boladi bosganda qayerga otishi
                    },
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.withOpacity(0.3),
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: Text("previous_trips".tr()),
                    leading: Assets.svgs.settings.svg(
                      width: 80.w,
                      height: 80.h,
                    ),
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {
                      // funksiya yozsa boladi bosganda qayerga otishi
                    },
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.withOpacity(0.3),
                    indent: 16,
                    endIndent: 16,
                  ),
                  CupertinoListTile(
                    title: Text("previous_trips".tr()),
                    leading: Assets.svgs.version.svg(width: 80.w, height: 80.h),
                    trailing: Icon(CupertinoIcons.forward),
                    onTap: () {
                      // funksiya yozsa boladi bosganda qayerga otishi
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statColumn(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(height: 40.h, width: 1, color: Colors.grey[300]);
  }
}

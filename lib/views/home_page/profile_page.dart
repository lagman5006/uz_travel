import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/gen/assets.gen.dart';
import 'package:uz_travel/views/favorites_page.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UzTravelProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            automaticallyImplyLeading: false,
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
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: provider.fetchUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final userProfile = provider.userProfile;
              return SingleChildScrollView(
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
                      userProfile?["firstName"] ?? 'User',
                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      userProfile?["lastName"] ?? '',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      userProfile?["email"] ?? 'No email',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                    SizedBox(height: 30.h),
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
                            },
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey.withValues(alpha: 0.3),
                            indent: 16,
                            endIndent: 16,
                          ),
                          CupertinoListTile(
                            leading: Icon(Icons.favorite_border),
                            title: Text('favorites'.tr()),
                            trailing: Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FavoritesPage();
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            thickness: 0.4,
                            color: Colors.grey.withValues(alpha: 0.3),
                            indent: 16,
                            endIndent: 16,
                          ),
                          CupertinoListTile(
                            title: Text("previous_trips".tr()),
                            leading: Assets.svgs.trip.svg(width: 80.w, height: 80.h),
                            trailing: Icon(CupertinoIcons.forward),
                            onTap: () {
                            },
                          ),
                          SizedBox(height: 10.h),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey.withValues(alpha: 0.3),
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
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
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
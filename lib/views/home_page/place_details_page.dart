import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:easy_localization/easy_localization.dart";

class PlaceDetailsPage extends StatelessWidget {
  final QueryDocumentSnapshot placeDoc;

  const PlaceDetailsPage({super.key, required this.placeDoc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(placeDoc["name"])),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (placeDoc["imagePath"] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  placeDoc["imagePath"],
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16.h),
            Text("${"location".tr()}: ${placeDoc["location"]}", style: TextStyle(fontSize: 18.sp)),
            SizedBox(height: 8.h),
            Text("${"price".tr()}: \$${placeDoc["price"]}", style: TextStyle(fontSize: 16.sp)),
            Text("${"rating".tr()}: ${placeDoc["rate"]} ⭐", style: TextStyle(fontSize: 16.sp)),
            SizedBox(height: 16.h),
            Text(placeDoc["description"], style: TextStyle(fontSize: 16.sp)),
          ],
        ),
      ),
    );
  }
}

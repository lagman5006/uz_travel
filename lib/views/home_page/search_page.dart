import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:easy_localization/easy_localization.dart";
import "city_search_delegate.dart";

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("cities".tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CitySearchDelegate());
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            "click_to_search".tr(),
            style: TextStyle(fontSize: 16.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

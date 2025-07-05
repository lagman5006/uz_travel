import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_madels/uztravel_provider.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> place;

  const DetailsPage({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 400.h, // Constrain the image height
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(place["imagePath"] ?? ''),
                fit: BoxFit.cover,

              ),
            ),
          ),
          // Title at the top center
          Positioned(
            top: 40.h,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Details",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 32.h,
            left: 16.w,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.withValues(alpha: 0.5),
              child: IconButton(
                icon:  Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Navigate back
                },
              ),
            ),
          ),
          Positioned(
            top: 32.h,
            right: 16.w,
            child: CircleAvatar(
              backgroundColor: Colors.grey.withValues(alpha: 0.5),
              child: IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {
                  final provider = Provider.of<UzTravelProvider>(context, listen: false);
                  provider.addFavourite(place["id"] ?? '');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to Favorites')),
                  );
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  boxShadow:  [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    // Drag Handle
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 5.h,
                        margin: EdgeInsets.only(bottom: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    // Place Name
                    Text(
                      place["name"] ?? "No Name",
                      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    // Location
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 20.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            place["location"] ?? "Unknown Location",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Rating
                    Row(
                      children: [
                        Icon(Icons.star, size: 20.sp, color: Colors.yellow[700]),
                        SizedBox(width: 8.w),
                        Text(
                          place["rate"] ?? "N/A",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 10.w,),
                        Text("\$${place["price"]}")
                      ],
                    ),
                    SizedBox(height: 10.h),
                    // Description
                    Text(
                      place["description"] ?? "No description available.",
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Additional Info",
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Add more details about the place here, such as activities, visiting hours, or other relevant information.",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
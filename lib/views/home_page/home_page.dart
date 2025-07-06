import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/home_page/details.dart';
import 'package:uz_travel/views/view_all.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UzTravelProvider>(
      builder: (context, uzTravelProvider, child) {
        return Scaffold(
          appBar: AppBar(
            leading: Switch(
              value: uzTravelProvider.isDarkMode,
              onChanged: (value) {
                uzTravelProvider.toggleTheme(value);
              },
              activeColor: Colors.blue,
              inactiveThumbColor: Colors.grey,
            ),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Explore The", style: TextStyle(fontSize: 40)),
                    ],
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Text("Beautiful",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                      Text("world",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35,color: Colors.red),)
                    ],
                  ),
                  Row(
                    children: [
                      Text("Best Destination"),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewAllPage(places: uzTravelProvider.places),
                            ),
                          );
                        },
                        child: Text("View all"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 500.h,
                    child: uzTravelProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: uzTravelProvider.places.length,
                            itemBuilder: (context, index) {
                              final place = uzTravelProvider.places[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsPage(place: place),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 180.w,
                                        height: 220.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              place["imagePath"] ?? '',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            place["name"] ?? 'No Name',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 50.w),
                                          Icon(Icons.star, size: 20),
                                          Text(place["rate"] ?? 'N/A'),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Text(place["location"]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

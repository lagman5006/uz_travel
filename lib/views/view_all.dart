import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/home_page/details.dart';
import 'package:uz_travel/widgets/addplacedialog.dart';

class ViewAllPage extends StatelessWidget {
  final List<Map<String, dynamic>> places;

  const ViewAllPage({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    final uzTravelProvider = Provider.of<UzTravelProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Text("All Places"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10.w,
          ),
          itemCount: places.length,
          itemBuilder: (context, index) {
            final place = places[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(place: place),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        place["imagePath"]?.isNotEmpty == true
                            ? place["imagePath"]!
                            : 'https://via.placeholder.com/150',
                        // Default placeholder
                        height: 120.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error, size: 50.sp),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place["name"] ?? 'No Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Expanded(
                                child: Text(
                                  place["location"] ?? 'Unknown Location',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 5,
                                children: [
                                  Icon(Icons.star, color: Colors.red),
                                  Text(place["rate"] ?? 'N/A'),
                                  Text("\$${place["price"] ?? '0'}"),
                                ],
                              ),
                      
                            ],
                          ),
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    final result =
                                    await showDialog<Map<String, dynamic>>(
                                      context: context,
                                      builder: (context) => AddplacedialogWidget(
                                        initialPlace: place,
                                        isEdit: true,
                                      ),
                                    );
                                    if (result != null && place["id"] != null) {
                                      await uzTravelProvider.updatePlace(
                                        place["id"],
                                        result,
                                      );
                                    }
                                  },
                                  icon: Icon(Icons.edit_rounded, size: 20.sp),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final shouldDelete = await showDialog<bool>(
                                      context: context,
                                      barrierDismissible: true,
                                      // Allow tapping outside to cancel
                                      builder: (context) => AlertDialog(
                                        title: Text("Confirm Delete"),
                                        content: Text(
                                          "Are you sure you want to delete this place?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: Text("No"),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, true),
                                            child: Text("Yes"),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (shouldDelete == true && place["id"] != null) {
                                      await uzTravelProvider.deletePlase(
                                        place["id"],
                                      ); // Fixed typo
                                      await uzTravelProvider.fetchPlaces();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (context) => AddplacedialogWidget(),
          );
          if (result != null) {
            await uzTravelProvider.addPlace(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

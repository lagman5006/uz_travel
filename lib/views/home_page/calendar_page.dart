import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/home_page/details.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDate;

  @override
  void initState() {
    _selectedDate = DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UzTravelProvider>(
        context,
        listen: false,
      ).fetchPlacesByDate(_selectedDate!);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UzTravelProvider>(context, listen: false);
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Schedule")),
      body: Center(
        child: Column(
          children: [
            CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                selectedDayHighlightColor: Colors.blue,
                weekdayLabelTextStyle: TextStyle(color: Colors.grey),
                dayTextStyle: TextStyle(color: Colors.black),
              ),
              value: _selectedDate != null ? [_selectedDate] : [DateTime.now()],
              onValueChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _selectedDate = value.first;
                  });
                }
              },
            ),
            Expanded(
              child: Consumer(
                builder: (context, value, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (provider.scheduledPlaces.isEmpty) {
                    return const Center(child: Text("No scheduled places"));
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: provider.scheduledPlaces.length,
                      itemBuilder: (context, index) {
                        final place = provider.scheduledPlaces[index];
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
                            margin: EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    place["imagePath"] ??
                                        'https://via.placeholder.com/150',
                                    width: double.infinity,
                                    height: 100.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        place["name"] ?? "No Name",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, size: 16.sp),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Text(
                                              place["location"] ??
                                                  "Unknown Location",
                                              style: TextStyle(fontSize: 12.sp),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

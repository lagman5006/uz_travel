import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UzTravelProvider>(context,listen: false);
    DateTime selectedDate = DateTime.now();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Schedule")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayHighlightColor: Colors.blue,
                  weekdayLabelTextStyle: TextStyle(color: Colors.grey),
                  dayTextStyle: TextStyle(color: Colors.black),
                ),
                value: [DateTime.now()],
                onValueChanged: (value) {
                  if (value.isNotEmpty){
                    selectedDate = value.first;
                    provider.fetchPlacesByDate(selectedDate);
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

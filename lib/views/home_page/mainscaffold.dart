import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';
import 'package:uz_travel/views/home_page/profile_page.dart';
import 'package:uz_travel/views/home_page/search_page.dart';

import 'calendar_page.dart';
import 'home_page.dart';
import 'messeges_page.dart';

class MainScaffold extends StatelessWidget {
  final List<Widget> _pages = [
    HomePage(),
    CalendarPage(),
    SearchPage(),

    MessegesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UzTravelProvider>(
      builder: (context, uzTravelProvider, child) {
        return Scaffold(
          body: IndexedStack(
            index: uzTravelProvider.currentIndex,
            children: _pages,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => uzTravelProvider.updateIndex(2),
            child: Icon(Icons.search),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.blue,
            currentIndex: uzTravelProvider.currentIndex,
            onTap: uzTravelProvider.updateIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: "Calendar",
              ),
              BottomNavigationBarItem(icon: SizedBox(), label: ""),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: "Message",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}

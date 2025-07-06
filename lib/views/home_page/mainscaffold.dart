import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:uz_travel/view_madels/uztravel_provider.dart";
import "package:uz_travel/views/home_page/city_list_page.dart";
import "package:uz_travel/views/home_page/profile_page.dart";
import "package:uz_travel/views/home_page/search_page.dart";
import "calendar_page.dart";
import "home_page.dart";

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UzTravelProvider>(
      builder: (context, uzTravelProvider, child) {
        final List<Widget> _pages = [
          HomePage(),
          CalendarPage(),
          SearchPage(),
          CityListPage(),
          ProfilePage(),
        ];

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

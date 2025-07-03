import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:uz_travel/view_madels/uztravel_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UzTravelProvider>(
      builder: (context, uzTravelProvider, child) {
        return Scaffold(
          appBar: AppBar(

            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(

            children: [
              Row(
                children: [

                ],
              ),
              Center(child: Text("HomePage")),
            ],
          ),
        );
      },
    );
  }
}

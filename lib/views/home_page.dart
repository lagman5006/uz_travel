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
            title: Container(
              width: 130.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),color: Colors.grey.withValues(alpha: 0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(Icons.person,color: Colors.red,),
                    Text("Iskandar")
                  ],
                ),
              ),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(onPressed: () {
                
              }, icon: Icon(Icons.notifications)),
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
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Row(
                  children: [
                    Text("Explore The",style: TextStyle(fontSize: 40),),
                  ],
                ),
                Row(
                  children: [
                    RichText(text: TextSpan(
                      text: "Beautiful ",style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: "world!",style: TextStyle(color: Colors.red,fontSize: 40)
                        )
                      ]
                    )),
                  ],
                )
              ]),
            ),
          ),
        );
      },
    );
  }
}

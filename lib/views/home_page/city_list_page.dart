import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:uz_travel/views/home_page/messeges_page.dart";

class CityListPage extends StatelessWidget {
  const CityListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shahar chatlari")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("city_chats").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final cities = snapshot.data!.docs;

          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final cityId = cities[index].id;

              return ListTile(
                title: Text(cityId),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessegesPage(cityId: cityId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

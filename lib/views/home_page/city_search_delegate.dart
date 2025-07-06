import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:easy_localization/easy_localization.dart";
import "package:uz_travel/views/home_page/details.dart";

class CitySearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => "search_hint".tr();

  // Qidiruv maydonining o‘ng tomonida chiqadigan tozalash (clear) tugmasi
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = "", // matnni tozalaydi
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null), // qidiruvni yopadi
    );
  }

  // Foydalanuvchi qidiruvni yakunlab, natija izlaganda ishlaydi
  @override
  Widget buildResults(BuildContext context) {
    return _buildCityList(query); // qidiruv natijalarini chiqarish
  }

  // Har bir harf yozilganda avtomatik chiqadigan previewlar
  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildCityList(query); // preview ro‘yxat
  }

  // Firestore'dan ma'lumot olib, ListView orqali shaharlar ro‘yxatini chiqarish
  Widget _buildCityList(String searchText) {
    if (searchText.isEmpty) {
      return Center(
        child: Text(
          "enter_city_name".tr(),
        ), // qidiruv matni bo‘sh bo‘lsa ogohlantirish
      );
    }

    final queryText = searchText.trim(); // bo‘sh joylarni olib tashlash

    // Firestore so‘rovi: "name" maydonida queryText bilan boshlanuvchilar
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection("places")
          .where("name", isGreaterThanOrEqualTo: queryText)
          .where("name", isLessThan: queryText + "z") // z — keyingi harf
          .get(),

      // Yuklanayotgan holatda progress indikatori
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Hech qanday natija topilmasa
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("no_city_found".tr()));
        }

        final docs = snapshot.data!.docs; // topilgan hujjatlar

        // Topilgan shaharlarni ro‘yxatda ko‘rsatish
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisExtent: 200.h,
            childAspectRatio: 0.75,
          ),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final place = docs[index];
            final imageUrl = place["imagePath"];
            final description = place["description"];
            return Card(
              elevation: 2,
              child: InkWell(
                onTap: () {
                  close(context, null);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        place: place.data() as Map<String, dynamic>,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(place["imagePath"]),
                    ),
                    Text(place["name"]),
                    Row(
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
        );
      },
    );
  }
}

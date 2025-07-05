import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:easy_localization/easy_localization.dart";
import "place_details_page.dart";

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
        child: Text("enter_city_name".tr()), // qidiruv matni bo‘sh bo‘lsa ogohlantirish
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
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final place = docs[index];

            return ListTile(
              title: Text(place["name"]), // shahar nomi
              subtitle: Text(place["location"]), // manzili
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              onTap: () {
                close(context, null); // qidiruvni yopadi
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceDetailsPage(placeDoc: place), // tafsilotlar sahifasi
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

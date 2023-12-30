import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/models/Category.model.dart';
import 'package:skeletons/skeletons.dart';

import '../../constants/url.dart';

class HomeCategoriesFilter extends StatefulWidget {
  const HomeCategoriesFilter({Key? key}) : super(key: key);

  @override
  _HomeCategoriesFilterState createState() => _HomeCategoriesFilterState();
}

class _HomeCategoriesFilterState extends State<HomeCategoriesFilter> {
  Future<List<Category>> categoriesFuture = getCategoryList();

  static Future<List<Category>> getCategoryList() async {
    String url = '${AppUrl.baseUrl}/categories/get_categories';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<Category>(Category.fromJson).toList();
  }

  Widget buildCategories(List<Category> categories) => ListView.builder(
      primary: false,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // <-- Radius
                ),
                side: const BorderSide(
                  width: 2.0,
                  color: Colors.white,
                ),
              ),
              child: Text(
                category.name!,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Row(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(8),
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.3),
              ),
            ],
          ));
        } else if (snapshot.hasData) {
          final categories = snapshot.data!;
          return buildCategories(categories);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/models/Category.model.dart';
import 'package:skeletons/skeletons.dart';

import '../../constants/url.dart';

class SearchGalleryCard extends StatefulWidget {
  const SearchGalleryCard({Key? key}) : super(key: key);

  @override
  _SearchGalleryCardState createState() => _SearchGalleryCardState();
}

class _SearchGalleryCardState extends State<SearchGalleryCard> {
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
      scrollDirection: Axis.vertical,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(category.image!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        category.name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: Icon(
                          Icons.local_activity,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Text(
                        1.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
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
              child: Column(
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    borderRadius: BorderRadius.circular(8),
                    height: 200,
                    width: 400),
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

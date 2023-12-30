import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../config/url.dart';
import '../../models/Category.model.dart';
import '../../theme/LetsGo_theme.dart';

class CustomCategoryFilter extends StatefulWidget {
  const CustomCategoryFilter({Key? key}) : super(key: key);

  @override
  State<CustomCategoryFilter> createState() => _CustomCategoryFilterState();
}

class _CustomCategoryFilterState extends State<CustomCategoryFilter> {
  Future<List<Category>> categoriesFuture = getCategoryList();
  bool? isPressed = false;

  static Future<List<Category>> getCategoryList() async {
    String url = '${AppUrl.baseUrl}/categories/get_categories';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<Category>(Category.fromJson).toList();
  }

  @override
  Widget buildCategories(List<Category> categories) => ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.name!,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: LetsGoTheme.black,
                ),
              ),
              SizedBox(
                height: 25,
                child: Checkbox(
                  value: isPressed,
                  onChanged: (value) {
                    setState(() {
                      isPressed = value;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildCategories(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

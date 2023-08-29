import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:LetsGo/widgets/custom_app_bar/custom_return_appbar.dart';
import 'package:flutter/material.dart';

import '../../widgets/filter/custom_category_filter.dart';
import '../../widgets/filter/custom_price_filter.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomReturnAppBar('Filtre', Colors.transparent, Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prix',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: LetsGoTheme.main,
                    ),
                  ),
                  const CustomPriceFilter(),
                  const SizedBox(height: 10),
                  Text(
                    'Catégorie',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: LetsGoTheme.main,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CustomCategoryFilter(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

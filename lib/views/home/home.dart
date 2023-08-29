import 'dart:convert';

import 'package:LetsGo/views/filter/filter_screen.dart';
import 'package:LetsGo/widgets/home/pub_two.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:LetsGo/globals.dart' as globals;
import 'package:LetsGo/models/Category.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/url.dart';
import '../../database/db_provider.dart';
import '../../provider/auth_provider.dart';
import '../../theme/LetsGo_theme.dart';
import '../../utils/routers.dart';
import '../../widgets/custom_app_bar/custom_app_bar.dart';
import '../../widgets/home/home_categories_filter.dart';
import '../../widgets/home/home_slider_geolocalisation.dart';
import '../../widgets/home/pub_one.dart';
import '../../widgets/home/home_slider_section.dart';
import '../../widgets/home/home_theme_section.dart';
import '../../widgets/home/home_vertical.dart';
import '../search/research.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthenticationProvider? user = AuthenticationProvider();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Category>> categoriesFuture = getCategoryList();
  dynamic getUser;

  @override
  void initState() {
    super.initState();
    saveUserFirebase();
  }

  static Future<List<Category>> getCategoryList() async {
    String url = '${AppUrl.baseUrl}/categories/get_categories';

    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    return body.map<Category>(Category.fromJson).toList();
  }

  void saveUserFirebase() async {
    String url = '${AppUrl.baseUrl}/auth/getAllUser';

    final response = await http.get(Uri.parse(url));

    final jsonResponse = jsonDecode(response.body);

    if (jsonResponse.length > 0) {
      jsonResponse.forEach((item) {
        _firestore.collection('users').doc(item['id']).set(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1630163670776-0f64ec1acf1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    height: 550,
                  ),
                  Container(
                    height: 550,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.bottomLeft,
                        end: FractionalOffset.topRight,
                        colors: [
                          const Color(0xFF302E76).withOpacity(0.6),
                          const Color(0xFF5B7CB8),
                        ],
                        stops: const [0.0, 1.0],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Regarde quoi faire à côté !',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: LetsGoTheme.white,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Research()),
                                                );
                                              },
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                              decoration: InputDecoration(
                                                fillColor: LetsGoTheme.white,
                                                filled: true,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        5.0, 15.0, 20.0, 15.0),
                                                suffixIcon: const IconButton(
                                                  color: Colors.black,
                                                  icon: Icon(Icons.search),
                                                  iconSize: 20.0,
                                                  onPressed: null,
                                                ),
                                                hintText:
                                                    'Rechercher des activités',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const FilterScreen()),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.menu_outlined,
                                        color: LetsGoTheme.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0, 15, 0, 20),
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(16, 0, 5, 0),
                            width: double.infinity,
                            height: 40,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              children: const [
                                HomeCategoriesFilter(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 30, 0, 0),
                child: Text(
                  'Nos recommendations ❤️',
                  style: LetsGoTheme.subTitle,
                ),
              ),
              const HomeSliderSection(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 30, 0, 0),
                child: Text(
                  'Les plus proches de chez vous',
                  style: LetsGoTheme.subTitle,
                ),
              ),
              const HomeSliderSectionGeolocalisation(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                child: Text(
                  'Mes amis',
                  style: LetsGoTheme.subTitle,
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Container(
                          width: 65,
                          height: 65,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/891/600',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Container(
                          width: 65,
                          height: 65,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/672/600',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Container(
                          width: 65,
                          height: 65,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/84/600',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Container(
                          width: 65,
                          height: 65,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/885/600',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Container(
                          width: 65,
                          height: 65,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/588/600',
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Container(
                          width: 65,
                          height: 65,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/241/600',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const PubOne(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                child: Text(
                  'Tendance à Paris',
                  style: LetsGoTheme.subTitle,
                ),
              ),
              const HomeSliderSection(),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                child: Text(
                  'Les activités du moment',
                  style: LetsGoTheme.subTitle,
                ),
              ),
              const HomeThemeSection(),
              const SizedBox(
                height: 30,
              ),
              const PubTwo(),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Text(
                  'Île-de-france - Les activitées les plus populaires',
                  style: LetsGoTheme.subTitle,
                ),
              ),
              const HomeVertical(),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

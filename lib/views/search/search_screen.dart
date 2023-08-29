import 'package:flutter/material.dart';
import 'package:LetsGo/views/search/research.dart';
import 'package:LetsGo/widgets/search/search_gallery_card.dart';
import 'package:LetsGo/widgets/search/search_maps_section.dart';

import '../../theme/LetsGo_theme.dart';
import '../../widgets/custom_app_bar/custom_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomAppBar(),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TextField(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Research()),
                        );
                      },
                      decoration: InputDecoration(
                        fillColor: LetsGoTheme.lightPurple,
                        filled: true,
                        contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        suffixIcon: Icon(Icons.search, color: LetsGoTheme.black),
                        hintText: 'Rechercher des activités ...',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SearchMapsSection(),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                  child: Text(
                    'Catégories',
                    style: LetsGoTheme.subTitle,
                  ),
                ),
                const SearchGalleryCard(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          )),
    );
  }
}

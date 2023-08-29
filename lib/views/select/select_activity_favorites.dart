/*
import 'package:flutter/material.dart';
import '../../theme/LetsGo_theme.dart';
import '../home/home_screen.dart';

class SelectActivityFavorites extends StatefulWidget {
  const SelectActivityFavorites({Key? key}) : super(key: key);

  @override
  _SelectActivityFavoritesState createState() =>
      _SelectActivityFavoritesState();
}

class _SelectActivityFavoritesState extends State<SelectActivityFavorites> {

  late TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  bool favoriteCategoryOfActivity = false;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: LetsGoTheme.main,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
               Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                child: Text('Sélectionnez 4 activités ou plus que vous aimez. ',
                    textAlign: TextAlign.start, style: LetsGoTheme.selectTitle),
              ),
              Align(
                alignment: const AlignmentDirectional(-0.05, -0.45),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 40),
                  child: TextFormField(
                    controller: textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Recherche',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: LetsGoTheme.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: LetsGoTheme.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                      prefixIcon:  Icon(
                        Icons.search,
                        color: LetsGoTheme.white,
                        size: 30,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
                  child: buildResult(context),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: ElevatedButton(
                  onPressed: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Terminer',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResult(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: (textController.text != "")
          ? FirebaseFirestore.instance
              .collection('categories')
              .where("title", arrayContains: textController.text)
              .snapshots()
          : FirebaseFirestore.instance.collection("categories").snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 4 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return Card(
                    shape: (selectedIndex == data['index'])
                        ? RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0))
                        : RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(4.0)),
                    elevation: 5,
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = data['index'];
                          favoriteCategoryOfActivity = true;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.7),
                                    BlendMode.saturation),
                                fit: BoxFit.cover,
                                image: NetworkImage(data['image'] ?? ''))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                data['title'] ?? '',
                                textAlign: TextAlign.center,
                                style: LetsGoTheme.selectSubTitle,
                              )),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }

  void initiateSearch(String val) {
    setState(() {
      textController = val as TextEditingController;
    });
  }
}
*/

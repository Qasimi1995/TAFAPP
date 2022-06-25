import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:chem/classes/language.dart';
import 'package:chem/localization/localization_constants.dart';
import 'package:chem/main.dart';
import 'package:chem/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'books_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showSuccessDialog() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void _changeLanguage(Language language) async {
    //print(language.languageCode);
    Locale _temp = await setLocale(language.languageCode);
    MyAppHome.setLocale(context, _temp);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[Colors.blue, Colors.blueAccent],
              )),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/Splash_screen.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        getTranslated(context, 'Math_Forms'),
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text(getTranslated(context, 'About Page')),
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text(getTranslated(context, 'Settings')),
            //   onTap: () {
            //     Navigator.pushNamed(context, settingsRoute);
            //   },
            // ),
          ],
        ),
      ),
      appBar: AppBar(
        title:
            //Using Localization class to localize the app in three language as below
            Text(getTranslated(context, 'Home Page')),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DropdownButton(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                        value: lang,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(lang.flag),
                            Text(
                              lang.name,
                              style: TextStyle(fontSize: 30),
                            )
                          ],
                        ),
                      ))
                  .toList(),
              onChanged: (Language? language) {
                _changeLanguage(language!);
              },
            ),
          ),
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) =>
            orientation == Orientation.portrait ? Vertical() : Landscape(),
      ),
    );
  }

  //Home Page for Vertical View
  Widget Vertical() {
    Locale myLocale = Localizations.localeOf(context);
    String localdata=myLocale.toLanguageTag();
    return ListView(
      children: <Widget>[
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 230.0,
                      width: double.infinity,
                      child: Carousel(
                        images: [
                          Image.asset(
                            'assets/slider/3.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/slider/2.jpg',
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10.0, bottom: 10.0, top: 10.0),
                      child: InkWell(
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/Icons/Chem_kankor.svg',
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                getTranslated(context, 'MathـKankorـForms'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Books_page(Language_Data:localdata)));
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: InkWell(
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/Icons/Chem_All_Books.svg',
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                getTranslated(context, 'MathVideos'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, MathVideoSelection);
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }

  //Home Page for Landscape View
  Widget Landscape() {
    Locale myLocale = Localizations.localeOf(context);
    String localdata=myLocale.toLanguageTag();
    return ListView(
      children: <Widget>[
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 250.0,
                      width: double.infinity,
                      child: Carousel(
                        images: [
                          Image.asset(
                            'assets/slider/3.jpg',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/slider/2.jpg',
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.46,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, right: 10, left: 10.0, bottom: 10.0),
                      child: InkWell(
                        child: Container(
                          height: 115.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/Icons/Chem_books.svg',
                                height: 70.0,
                                width: 70.0,
                              ),
                              Text(
                                getTranslated(context, 'MathـKankorـForms'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Books_page(Language_Data:localdata)));
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10, left: 10.0, bottom: 10.0),
                        child: InkWell(
                          child: Container(
                            height: 115.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/Icons/Chem_All_Books.svg',
                                  height: 70.0,
                                  width: 70.0,
                                ),
                                Text(
                                  getTranslated(context, 'MathVideos'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, MathVideoSelection);
                          },
                        )),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}

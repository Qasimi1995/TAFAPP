import 'package:chem/Pages/home_page.dart';
import 'package:chem/classes/language.dart';
import 'package:chem/localization/localization_constants.dart';
import 'package:chem/main.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../routes/route_name.dart';

class Introduction_Screen extends StatefulWidget {
  Introduction_Screen({Key? key}) : super(key: key);

  @override
  State<Introduction_Screen> createState() => _Introduction_ScreenState();
}

class _Introduction_ScreenState extends State<Introduction_Screen> {
  //Using this function to localize the app Language
  void _changeLanguage(Language language) async {
    //print(language.languageCode);
    Locale _temp = await setLocale(language.languageCode);
    MyAppHome.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Introduction')),
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
        centerTitle: true,
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
                title: getTranslated(context, 'First_Page'),
                body: getTranslated(context, 'First_Page_Description'),
                footer: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: DropdownButton(
                    underline: SizedBox(),
                    hint:Text(getTranslated(context, 'Select_Lang'),style: TextStyle(fontSize: 15, color: Colors.black),) ,
                    icon: Icon(
                       Icons.language, size: 15,
                      color: Colors.blue,
                    ),
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                            (lang) => DropdownMenuItem(
                                  value: lang,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                image: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Image.asset('assets/Introduction/Page 1.png'),
                  ),
                ),
                decoration: const PageDecoration(
                    titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))),
            PageViewModel(
                title: getTranslated(context, 'second_page'),
                body: getTranslated(context, 'second_des'),
                // footer: ElevatedButton(
                //   onPressed: () {},
                //   child: Text("Lets Go"),
                // ),
                image: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset('assets/Introduction/Page 2.png'),
                  ),
                ),
                decoration: const PageDecoration(
                    titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))),
            // PageViewModel(
            //     title: 'Third Page',
            //     body: 'Description',
            //     // footer: ElevatedButton(
            //     //   onPressed: () {},
            //     //   child: Text("Lets Go"),
            //     // ),
            //     image: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Center(
            //         child: Image.asset('assets/Introduction/Page 3.png'),
            //       ),
            //     ),
            //     decoration: const PageDecoration(
            //         titleTextStyle: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ))),
            PageViewModel(
                title: getTranslated(context, 'last_page'),
                body: getTranslated(context, 'last_des'),
                // footer: ElevatedButton(
                //   onPressed: () {},
                //   child: Text("Lets Go"),
                // ),
                image: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Image.asset('assets/Introduction/Page 4.png'),
                  ),
                ),
                decoration: const PageDecoration(
                    titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))),
          ],
          dotsDecorator: const DotsDecorator(
            size: Size(10, 10),
            color: Colors.blue,
            activeSize: Size.square(20),
            activeColor: Colors.red,
          ),
          showDoneButton: true,
          done:  Text(
            getTranslated(context, 'Done'),
            style: TextStyle(fontSize: 20),
          ),
          showSkipButton: true,
          skip: Text(getTranslated(context, 'Skip'), style: TextStyle(fontSize: 20),),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 20,
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('Introduction', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}

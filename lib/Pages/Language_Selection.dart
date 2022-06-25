import 'dart:ui';
import 'package:chem/classes/language.dart';
import 'package:chem/localization/localization_constants.dart';
import 'package:chem/main.dart';
import 'package:chem/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Language_Selection extends StatefulWidget {
  const Language_Selection({Key? key}) : super(key: key);

  @override
  _Language_SelectionState createState() => _Language_SelectionState();
}

class _Language_SelectionState extends State<Language_Selection> {
  void _changeLanguage(Language language) async {
    //print(language.languageCode);
    Locale _temp = await setLocale(language.languageCode);
    MyAppHome.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Select_Lang')),
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
      body:Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                      height:MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: Text(
                         'ژبه غوره کړئ' +'\n \n'+

                          'انتخاب زبان',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.19,
            ),
            Container(
              height: 150,
              child:  Padding(
                padding: EdgeInsets.all(8.0),
                child: DropdownButton(
                  dropdownColor: Colors.blue,
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.language,
                    color: Colors.blue,
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
            )



          ],
        ),
      )
    );
  }
}

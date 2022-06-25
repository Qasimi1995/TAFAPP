import 'package:chem/localization/localization_constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:introduction_screen/introduction_screen.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'About Page')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                height:MediaQuery.of(context).size.height * 0.3,
               // width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: Image.asset('assets/Introduction/Page 4.png'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                height:MediaQuery.of(context).size.height * 0.2,
               // width: MediaQuery.of(context).size.width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: Text(getTranslated(context, 'AboutUs_Info'),textAlign: TextAlign.center, style: TextStyle(fontSize:15, fontWeight: FontWeight.bold, ),),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

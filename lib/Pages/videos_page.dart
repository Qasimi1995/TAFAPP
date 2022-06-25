
import 'package:chem/localization/localization_constants.dart';
import 'package:flutter/material.dart';

class Videos_page extends StatefulWidget {
  const Videos_page({Key? key}) : super(key: key);

  @override
  _Videos_pageState createState() => _Videos_pageState();
}

class _Videos_pageState extends State<Videos_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text(getTranslated(context,'About Page')),
      ),
    );
  }
}

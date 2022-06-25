import 'package:chem/localization/localization_constants.dart';
import 'package:flutter/material.dart';

class Chemistry extends StatelessWidget {
  const Chemistry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title:  Text(getTranslated(context,'Chemistry Books')),
      ),
    );
  }
}

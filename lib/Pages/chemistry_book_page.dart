import 'package:flutter/material.dart';

class Chemistry extends StatelessWidget {
  const Chemistry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Chemistry Books'),
      ),
    );
  }
}

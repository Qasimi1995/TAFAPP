import 'package:chem/Pages/Chemistry_Books.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Chemistry'),
      ),
      

      body: Container(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Chemistry(),
              ),
            );
          },
          child: const Card(
            elevation: 13,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
              child: Text(
                'Chemistry Books',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:chem/localization/localization_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Book_Entry extends StatefulWidget {
  const Book_Entry({Key? key}) : super(key: key);

  @override
  _Book_EntryState createState() => _Book_EntryState();
}

class _Book_EntryState extends State<Book_Entry> {
  CollectionReference Books =
      FirebaseFirestore.instance.collection('chem_book');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Books')),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Enter the data'),
          ),
          ElevatedButton(
              onPressed: () async {
                await Books.add({'Book_Name': 'Fawad'})
                    .then((value) => print('User Added'));
              },
              child: const Text('Submit')),
        ],
      ),
    );
  }
}

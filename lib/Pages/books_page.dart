import 'dart:developer';
import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:chem/localization/localization_constants.dart';
import 'package:chem/routes/route_name.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'books_details_page.dart';

class Books_page extends StatefulWidget {
  final Language_Data;
  Books_page({Key? key, this.Language_Data}) : super(key: key);

  @override
  _Books_pageState createState() => _Books_pageState();
}

class _Books_pageState extends State<Books_page> {
  bool isSearching = false;
  FirebaseFirestore _Books = FirebaseFirestore.instance;
  List<DocumentSnapshot> book_details = [];
  List<DocumentSnapshot> _book_details_filter_Data = [];
  int _books_per_page = 100;
  late DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreBooks = false;
  bool _moreBooksAvailable = true;
  bool _loadingBooks = true;

  _getBooks() async {
    Query q = _Books.collection("Math_forms")
        .where("Lang", isEqualTo: widget.Language_Data)
        .orderBy('order', descending: false)
        .limit(_books_per_page);

    setState(() {
      _loadingBooks = true;
    });
    QuerySnapshot querySnapshot = await q.get();
    book_details = querySnapshot.docs;
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    setState(() {
      _loadingBooks = false;
    });
  }

  _getMoreBooks() async {
    print("Get more Books called");
    if (_moreBooksAvailable == false) {
      return;
    }
    if (_gettingMoreBooks == true) {
      return;
    }
    _gettingMoreBooks = true;
    Query q = _Books.collection("Math_forms")
        .where("Lang", isEqualTo: widget.Language_Data)
        .orderBy('order', descending: false)
        .startAfter([_lastDocument["Form_Title"]]).limit(_books_per_page);
    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < _books_per_page) {
      _moreBooksAvailable = false;
    }

    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    book_details.addAll(querySnapshot.docs);
    _gettingMoreBooks = false;
  }

  @override
  void initState() {
    _getBooks();
    super.initState();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        _getMoreBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(getTranslated(context, 'Math_Forms_PDF_List'))
                // !isSearching
                //     ? Text(getTranslated(context, 'Books'))
                //     : TextField(
                //         onChanged: (value) {
                //           // _FilterBooks(value);
                //         },
                //         style: TextStyle(color: Colors.black),
                //         decoration: InputDecoration(
                //             icon: Icon(
                //               Icons.search,
                //               color: Colors.black,
                //             ),
                //             hintText: getTranslated(context, 'Search Here'),
                //             hintStyle: TextStyle(color: Colors.black)),
                //       ),
                // actions: <Widget>[
                //   isSearching
                //       ? IconButton(
                //           icon: Icon(Icons.cancel),
                //           onPressed: () {
                //             setState(() {
                //               this.isSearching = false;
                //             });
                //           },
                //         )
                //       : IconButton(
                //           icon: Icon(Icons.search),
                //           onPressed: () {
                //             setState(() {
                //               this.isSearching = true;
                //             });
                //           },
                //         )
                // ],
                ),
        body: _loadingBooks == true
            ? Card(
                child: Center(
                  child: Text(getTranslated(context, 'Loading')),
                ),
              )
            : Card(
                child: book_details.length == 0
                    ? Center(
                        child: Text("No Books To Show"),
                      )
                    : Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/Icons/Chem_books.svg',
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  Text(
                                    getTranslated(context, 'Maths_Forms'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: _listView(context))
                        ],
                      )));
  }

  ListView _listView(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: book_details.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListTile(
                tileColor: Colors.blue,
                isThreeLine: true,
                title: Container(
                  height: 80,
                  child: Text(
                    (book_details[index]['Form_Title']),
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                subtitle:
                    // Container(
                    //   height: 30 ,
                    //   alignment: Alignment.bottomLeft,
                    //   child: RichText(
                    //     text: TextSpan(
                    //       children: [
                    //         WidgetSpan(
                    //           child: Icon(Icons.file_download_outlined, size: 18),
                    //         ),
                    //         TextSpan(
                    //           text:' ' + book_details[index]['Form_Size'],
                    //           // DateFormat('dd-MM-yyyy')
                    //           //     .format((book_details[index]
                    //           // ['Book_Publish_Date']
                    //           //     .toDate()))
                    //           //     .toString(),
                    //
                    //           style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                        height: 30,
                        child: Row(
                          children: [
                            // RichText(
                            //   textAlign: TextAlign.left,
                            //   text: TextSpan(
                            //     children: [
                            //       WidgetSpan(
                            //         child: Icon(Icons.file_present, size: 15),
                            //       ),
                            //       TextSpan(
                            //         text:
                            //             ' ' + book_details[index]['Form_Size'],
                            //         style: TextStyle(
                            //             color: Colors.black,
                            //             fontWeight: FontWeight.bold),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 8,
                            // ),
                            RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.file_copy_rounded, size: 15),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ' + book_details[index]['Form_Pages'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Book_details(
                          book_detail: book_details[index]['Form_PDF_Link'])));
                },
                dense: true,
                trailing: Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 70,
                    minHeight: 60,
                    maxWidth: 70,
                    maxHeight: 60,
                  ),
                  child: Image.network(
                    book_details[index]['Form_Thumbnail_Link'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ]);
        });
  }
}

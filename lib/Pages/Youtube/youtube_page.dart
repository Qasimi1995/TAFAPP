import 'package:chem/Pages/Youtube/youtube_details.dart';
import 'package:chem/localization/localization_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Youtube_Page extends StatefulWidget {
  final value;
  final LangData;
  const Youtube_Page({Key? key, this.value, this.LangData}) : super(key: key);

  @override
  _Youtube_PageState createState() => _Youtube_PageState();
}

class _Youtube_PageState extends State<Youtube_Page> {
  bool isSearching = false;
  FirebaseFirestore _Videos = FirebaseFirestore.instance;
  List<DocumentSnapshot> Videos_details = [];
  List<DocumentSnapshot> _book_details_filter_Data = [];
  int _Videos_per_page = 2000;
  late DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreVideos = false;
  bool _moreVideosAvailable = true;
  bool _loadingVideos = true;

  _getVideos() async {
    print("values"+widget.value);
    print("language" + widget.LangData);

    Query q = await _Videos.collection("Videos")
        .where("Video_Form", isEqualTo: widget.value)
        .where("Lang", isEqualTo: widget.LangData)
         .orderBy('order', descending: false)
        .limit(_Videos_per_page);
    setState(() {
      _loadingVideos = true;
    });

    QuerySnapshot querySnapshot = await q.get();
    Videos_details = querySnapshot.docs;
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    setState(() {
      _loadingVideos = false;
    });

  }

  _getMoreVideos() async {
    print("Get more Books called");
    if (_moreVideosAvailable == false) {
      return;
    }
    if (_gettingMoreVideos == true) {
      return;
    }

    _gettingMoreVideos = true;

    Query q = _Videos.collection("Videos")
        .where("Video_Form", isEqualTo: widget.value)
        .where("Lang", isEqualTo: widget.LangData)
        .orderBy('order', descending: false)
        .startAfter([_lastDocument['Video_Pages']]).limit(_Videos_per_page);
    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < _Videos_per_page) {
      _moreVideosAvailable = false;
    }

    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    Videos_details.addAll(querySnapshot.docs);
    _gettingMoreVideos = false;
  }

  @override
  void initState() {
    _getVideos();
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll <= delta) {
        _getMoreVideos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:Text(getTranslated(context, 'Math Forms Video List'))
          // !isSearching
          //     ? Text(getTranslated(context, 'Math Forms Video List'))
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
        body: _loadingVideos == true
            ? Card(
          child: Center(
            child: Text(getTranslated(context, 'Loading')),
          ),
        )
            : Card(
            child: Videos_details.length == 0
                ? Center(
              child: Text("No Videos To Load"),
            )
                : _listView(context)));
  }

  ListView _listView(BuildContext context) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: Videos_details.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: ListTile(
                tileColor: Colors.blue,
                isThreeLine: true,
                title:
                Container(
                  height: 80,
                  child: Text(
                    (Videos_details[index]['Video_Pages']).toString(),
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                ),
                subtitle: Container(
                  height: 18,
                  alignment: Alignment.bottomLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.timelapse, size: 18),
                        ),
                        TextSpan(
                          text: ' ' +  Videos_details[index]['Video_Duration'],
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Youtube_Video_Details(
                        Videos_details: Videos_details[index]
                        ['Video_links'],
                        Video_Pages: Videos_details[index]['Video_Pages'],
                        Video_Form: Videos_details[index]['Video_Title'],
                        Video_Duration: Videos_details[index]
                        ['Video_Duration'],
                      )));
                },
                trailing: Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints.expand(
                    height: 110,
                    width: 100,
                  ),
                  child: Image.network(
                    Videos_details[index]['Video_Thumbnail'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ]);
        });
  }
}

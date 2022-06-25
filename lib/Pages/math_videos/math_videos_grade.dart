import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../localization/localization_constants.dart';
import '../../routes/route_name.dart';
import '../Youtube/youtube_page.dart';
import 'math_videos_page.dart';

class Math_Video_Grade extends StatefulWidget {
  const Math_Video_Grade({Key? key}) : super(key: key);

  @override
  _Math_Video_GradeState createState() => _Math_Video_GradeState();
}

class _Math_Video_GradeState extends State<Math_Video_Grade> {
  bool isSearching = false;
  FirebaseFirestore _Videos_Form = FirebaseFirestore.instance;
  List<DocumentSnapshot> Videos_Forms = [];
  // List<DocumentSnapshot> _book_details_filter_Data = [];
  int _Videos_Form_per_page = 2000;
  late DocumentSnapshot _lastDocument;
  ScrollController _scrollController = ScrollController();
  bool _gettingMoreVideosForms = false;
  bool _moreVideosFormsAvailable = true;
  bool _loadingVideos = true;

  _getVideos() async {
    Query q = _Videos_Form.collection("Video_Math_List")
        .orderBy('order', descending: false)
        .limit(_Videos_Form_per_page);
    setState(() {
      _loadingVideos = true;
    });
    QuerySnapshot querySnapshot = await q.get();
    Videos_Forms = querySnapshot.docs;
    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];

    setState(() {
      _loadingVideos = false;
    });
  }

  _getMoreVideos() async {
    print("Get more Books called");
    if (_moreVideosFormsAvailable == false) {
      return;
    }
    if (_gettingMoreVideosForms == true) {
      return;
    }

    _gettingMoreVideosForms = true;

    Query q = _Videos_Form.collection("Video_Math_List")
        .startAfter([_lastDocument['Grade_No']])
        .orderBy('order',descending: false)
        .limit(_Videos_Form_per_page);
    QuerySnapshot querySnapshot = await q.get();

    if (querySnapshot.docs.length < _Videos_Form_per_page) {
      _moreVideosFormsAvailable = false;
    }

    _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    Videos_Forms.addAll(querySnapshot.docs);
    _gettingMoreVideosForms = false;
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
          title: Text(
            getTranslated(context, 'math_video_list'),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _loadingVideos == true
            ? Card(
          child: Center(
            child: Text(getTranslated(context, 'Loading')),
          ),
        )
            : Card(
            child: Videos_Forms.length == 0
                ? Center(
              child: Text("No Videos To Load"),
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
                          'assets/Icons/Chem_videos.svg',
                          height: 40.0,
                          width: 40.0,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          getTranslated(context, 'Videos'),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _listView(context),
                )
              ],
            )
        ));
  }

  ListView _listView(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    String localdata=myLocale.toLanguageTag();
    return ListView.builder(
        controller: _scrollController,
        itemCount: Videos_Forms.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text(
                      Videos_Forms[index]['Grade_No'],
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Center(
                    child: Text(
                      getTranslated(context, 'GradeName') +
                          ' ' +
                          Videos_Forms[index]['Grade_No'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Math_Video_Page(
                                value: Videos_Forms[index]['Grade_No'], LangData:localdata)));
                  },
                ),
              ),
            ),
          ]);
        });
  }
}

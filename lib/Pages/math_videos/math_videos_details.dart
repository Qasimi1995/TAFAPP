import 'dart:async';
import 'dart:io';
import 'package:chem/localization/localization_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../localization/localization_constants.dart';

class Math_Videos_Details extends StatefulWidget {
  final Videos_details;
  final Video_Pages;
  final Video_Duration;
  final Video_Form;
  const Math_Videos_Details({Key? key,
    required this.Videos_details,
    this.Video_Pages,
    this.Video_Duration,
    this.Video_Form}) : super(key: key);

  @override
  _Math_Videos_DetailsState createState() => _Math_Videos_DetailsState();
}

class _Math_Videos_DetailsState extends State<Math_Videos_Details> {
  bool loading = true;
  String? Video_ID;
  YoutubePlayerController? _controller;

//  Getting PDF and convert to PDFDocument using below function
  Future Video_load() async {
    RegExp regExp = new RegExp(
      r'.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );
    final match = regExp
        .firstMatch(widget.Videos_details)
        ?.group(1); // <- This is the fix
    Video_ID = match;
    setState(() {
      loading = false;
    });
  }

  //All functions get called using initState

  void dispose() {
    // _controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Video_load();
  }

  @override
  @override
  Widget build(BuildContext context) {
    //  _controller = YoutubePlayerController(
    //     initialVideoId: Video_ID!,
    //     flags: YoutubePlayerFlags(
    //       hideControls: false,
    //       controlsVisibleAtStart: false,
    //       autoPlay: true,
    //       mute: false,
    //       isLive: false,
    //       hideThumbnail: false,
    //       enableCaption: true,
    //     ),
    // );
    _controller = YoutubePlayerController(
        initialVideoId: Video_ID!,
        params: YoutubePlayerParams(
          loop: true,
          color: 'transparent',
          desktopMode: true,
          strictRelatedVideos: true,
          showFullscreenButton: !kIsWeb,
        ));
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'math_Video_Play'),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) =>
        orientation == Orientation.portrait ? Vertical() : Landscape(),
      ),
    );
  }

  Widget Vertical() {
    return Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: loading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    : YoutubePlayerControllerProvider(
                  controller: _controller!,
                  child: YoutubePlayerIFrame(
                    controller: _controller,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.19,
                color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      child: Center(
                        child: Text(
                          widget.Video_Pages,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 20),
                      child: Container(
                          height: 30,
                          child: Row(
                            children: [
                              RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.timelapse, size: 20),
                                    ),
                                    TextSpan(
                                      text: ' ' + widget.Video_Duration,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.23,
                              ),
                              RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Icon(Icons.list, size: 20),
                                    ),
                                    TextSpan(
                                      text: ' ' + widget.Video_Form,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  right: 10,
                  left: 10.0,
                ),
                child: InkWell(
                    child:   Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/Icons/youtube-play.svg',
                            height: 40.0,
                            width: 40.0,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            getTranslated(context, 'Play_on_Youtube'),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          )
                        ],
                      ),

                    ),
                    onTap: (){
                      _launch_URL(widget.Videos_details);
                    }

                )),
          ],
        ));
  }

  Widget Landscape() {
    return Row(children: <Widget>[
      Container(
          width: MediaQuery.of(context).size.width * 0.46,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 135.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.Video_Pages,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: RichText(
                                      textAlign: TextAlign.right,
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child:
                                            Icon(Icons.timelapse, size: 20),
                                          ),
                                          TextSpan(
                                            text: ' ' + widget.Video_Duration,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1),
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.list, size: 20),
                                        ),
                                        TextSpan(
                                          text: ' ' + widget.Video_Form,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            right: 10,
                            left: 10.0,
                          ),
                          child: InkWell(
                              child:   Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/Icons/youtube-play.svg',
                                      height: 40.0,
                                      width: 40.0,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      getTranslated(context, 'Play_on_Youtube'),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    )
                                  ],
                                ),

                              ),
                              onTap: (){
                                _launch_URL(widget.Videos_details);
                              }

                          )),
                    ],
                  )),
            ],
          )),
      Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(8),
          child: loading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : YoutubePlayerControllerProvider(
            controller: _controller!,
            child: YoutubePlayerIFrame(
              controller: _controller,
            ),
          ))
    ]);
  }
}

_launch_URL(dynamic URL) async{
  String My_Link = URL;
  String MyNew_Link = My_Link.substring(5);
  String Youtube_Link= "youtube" + MyNew_Link;
  if(Platform.isAndroid){
    if (!await launch(My_Link)) throw 'Can not Open The URL';

  }

}


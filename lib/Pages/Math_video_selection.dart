import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../localization/localization_constants.dart';
import '../routes/route_name.dart';

class Math_Video_Selection extends StatefulWidget {
  const Math_Video_Selection({Key? key}) : super(key: key);

  @override
  _Math_Video_SelectionState createState() => _Math_Video_SelectionState();
}

class _Math_Video_SelectionState extends State<Math_Video_Selection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'math_All_Videos')),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) =>
        orientation == Orientation.portrait ? Vertical() : Landscape(),
      ),
    );
  }

  //Home Page for Vertical View
  Widget Vertical() {
    // Locale myLocale = Localizations.localeOf(context);
    // String localdata=myLocale.toLanguageTag();
    return ListView(
      children: <Widget>[
        Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/Icons/all_videos.svg',
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
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: InkWell(
                        child: Container(
                          height:240,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/Icons/Chem_videos.svg',
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                getTranslated(context, 'Math_Forms_Videos'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, youtubeGradeRoute);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: InkWell(
                        child: Container(
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/Icons/math_videos.svg',
                                height: 90.0,
                                width: 90.0,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                getTranslated(context, 'MathVideos'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, MathVideoGrade);
                        },
                      ),
                    ),
                  ],
                )),
            // Container(
            //     height: MediaQuery.of(context).size.height * 0.5,
            //     child: Column(
            //       children: [
            //
            //         Padding(
            //           padding:
            //           const EdgeInsets.only(top: 10, left: 10, right: 10),
            //           child: InkWell(
            //             child: Container(
            //               height: 250,
            //               width: MediaQuery.of(context).size.width,
            //               decoration: BoxDecoration(
            //                 color: Colors.blue,
            //               ),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   SvgPicture.asset(
            //                     'assets/Icons/Chem_videos.svg',
            //                     height: 90.0,
            //                     width: 90.0,
            //                   ),
            //                   SizedBox(
            //                     height: 10,
            //                   ),
            //                   Text(
            //                     getTranslated(context, 'Math_Forms_Videos'),
            //                     style: TextStyle(
            //                         color: Colors.black,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 25),
            //                   )
            //                 ],
            //               ),
            //             ),
            //             onTap: () {
            //               Navigator.pushNamed(context, youtubeGradeRoute);
            //             },
            //           ),
            //         ),
            //       ],
            //     )),
          ],
        ),
      ],
    );
  }

  //Home Page for Landscape View
  Widget Landscape() {
    Locale myLocale = Localizations.localeOf(context);
    String localdata=myLocale.toLanguageTag();
    return ListView(
      children: <Widget>[
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10, left: 10.0, bottom: 10.0),
                        child: InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.74,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/Icons/Chem_videos.svg',
                                  height: 100.0,
                                  width: 100.0,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  getTranslated(context, 'Math_Forms_Videos'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, youtubeGradeRoute);
                          },
                        )),

                  ],
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 10, left: 10.0, bottom: 10.0),
                        child: InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.74,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/Icons/math_videos.svg',
                                  height: 110.0,
                                  width: 110.0,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  getTranslated(context, 'MathVideos'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, MathVideoGrade);
                          },
                        )),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}

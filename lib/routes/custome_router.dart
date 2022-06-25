import 'package:chem/Pages/Youtube/youtube_grade.dart';
import 'package:chem/Pages/about_page.dart';
import 'package:chem/Pages/books_details_page.dart';
import 'package:chem/Pages/books_page.dart';
import 'package:chem/Pages/data_entry_book.dart';
import 'package:chem/Pages/home_page.dart';
import 'package:chem/Pages/books_grade.dart';
import 'package:chem/Pages/notfound_page.dart';
import 'package:chem/routes/route_name.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case aboutRoute :
        return MaterialPageRoute(builder: (_) => AboutPage());
      case booksRoute :
        return MaterialPageRoute(builder: (_) => Books_page());
      case booksGradeRoute :
        return MaterialPageRoute(builder: (_) => Books_Grade());
      case youtubeGradeRoute :
        return MaterialPageRoute(builder: (_) => Youtube_Grade());
      default:
        return MaterialPageRoute(builder: (context) => NotFoundPage());
    }
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chem/Pages/Introduction/Introduction_Screen.dart';
import 'package:chem/Pages/Language_Selection.dart';
import 'package:chem/Pages/home_page.dart';
import 'package:chem/localization/localization_chem.dart';
import 'package:chem/routes/custome_router.dart';
import 'package:chem/routes/route_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/localization_constants.dart';
import 'package:page_transition/page_transition.dart';

bool Show=true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
 //Here we use this line for introduction screen
  final prefs=  await SharedPreferences.getInstance();
  Show = await prefs.getBool('Introduction') ?? true;
  runApp(MyAppHome());
}

  class SplashScreen_Animated extends StatelessWidget {
    const SplashScreen_Animated({Key? key}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return AnimatedSplashScreen(
          splash: Lottie.asset('assets/93585-maths-formula.json'),
         // backgroundColor: Colors.blue,
          nextScreen: const HomePage(),
          duration: 3000,
          splashTransition: SplashTransition.slideTransition,
          pageTransitionType: PageTransitionType.rightToLeft,
          animationDuration: const Duration(seconds: 2),
          splashIconSize: 250,
         );
    }
  }
  


class MyAppHome extends StatefulWidget {
  const MyAppHome({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppHomeState? state = context.findAncestorStateOfType<_MyAppHomeState>();
    state?.setLocale(locale);
  }

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // if (_locale == null) {
    //   return Container(
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // } else{
      return MaterialApp(
        title: 'Kankor Math Forms',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:   Show ? Introduction_Screen() : SplashScreen_Animated() ,
        locale: _locale,
        supportedLocales: [
          Locale('ps', 'ps-AR'),
          Locale('fa','IR'),
          Locale('en','US'),
        ],
        localizationsDelegates: [
          LocalizationChem.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        localeResolutionCallback: (deviceLocal, supportedLocales){
          for(var locale in supportedLocales){
            if(locale.languageCode == deviceLocal!.languageCode && locale.countryCode == deviceLocal.countryCode){
              return deviceLocal;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        onGenerateRoute: CustomRouter.allRoutes,
        initialRoute: homeRoute,
      );
    }

  }


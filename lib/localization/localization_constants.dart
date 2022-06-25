import 'package:chem/localization/localization_chem.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context, String key){
  return LocalizationChem.of(context).getTranslatedValue(key);
}

//Language Code

const String ENGLISH = 'en';
const String FARSI = 'fa';
const String PASHTO = 'ps';

//Language Code
const String LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();

 await  _prefs.setString(LANGUAGE_CODE, languageCode);

 return _locale(languageCode);
}
Locale _locale(String languageCode){

  Locale _temp;
  switch (languageCode) {
    case FARSI:
      _temp = Locale(languageCode, 'IR');
      break;
    case PASHTO:
      _temp = Locale(languageCode, 'ps-AR');
      break;
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    default:
        _temp = Locale(FARSI, 'IR');
  }
 return _temp;

}

Future<Locale> getLocale() async{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);

}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationChem {
   final Locale locale;

  LocalizationChem(this.locale);


  static LocalizationChem of(BuildContext context) {
    return Localizations.of<LocalizationChem>(context, LocalizationChem)!;
  }

  late Map<String, String>  _localizedValues;

  Future load() async{
    String jsonStringValues = await rootBundle.loadString('lib/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = mappedJson.map((key, value) => MapEntry(key,value.toString()));

  }

    getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<LocalizationChem> delegate = _LocalizationChemDelegate();
}

class _LocalizationChemDelegate extends LocalizationsDelegate<LocalizationChem>{
  const _LocalizationChemDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['ps','fa','en'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationChem> load(Locale locale) async{
   LocalizationChem localization = new LocalizationChem(locale);
   await localization.load();
   return localization;
  }

  @override
  bool shouldReload(_LocalizationChemDelegate old) => false;
  
}
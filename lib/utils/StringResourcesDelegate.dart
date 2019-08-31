import 'package:ds_appcobro/utils/StringResources.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StringResourcesDelegate extends LocalizationsDelegate<StringResources> {
  const StringResourcesDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<StringResources> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return new SynchronousFuture<StringResources>(new StringResources(locale));
  }
  @override
  bool shouldReload(StringResourcesDelegate old) => false;
}
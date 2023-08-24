import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/core/model/language.model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final userLanguageCodeProvider = StateProvider<String>((ref) {
  return 'en';
});

final languagesSupportProvider = Provider.family<List<Language>, BuildContext>((ref, context) {
  return [
    Language(code: 'en', label: AppLocalizations.of(context)!.english),
    Language(code: 'es', label: AppLocalizations.of(context)!.spanish),
  ];
});

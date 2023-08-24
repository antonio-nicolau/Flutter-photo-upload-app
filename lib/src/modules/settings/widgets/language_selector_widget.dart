import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:wisy_image_uploader/src/core/model/language.model.dart';
import 'package:wisy_image_uploader/src/modules/settings/state/language_state.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(userLanguageCodeProvider);
    final supportedLanguages = ref.watch(languagesSupportProvider(context));
    final selectedLanguage = supportedLanguages.where((e) => languageCode == e.code).first;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.select_language,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        DropdownButton<Language>(
          value: selectedLanguage,
          onChanged: (Language? value) {
            if (value == null) return;
            ref.read(userLanguageCodeProvider.notifier).state = value.code;
          },
          items: supportedLanguages.map<DropdownMenuItem<Language>>((Language value) {
            return DropdownMenuItem<Language>(
              value: value,
              child: Text(value.label ?? ''),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Text(
          '${AppLocalizations.of(context)!.selected_language} ${selectedLanguage.label}',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

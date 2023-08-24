import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wisy_image_uploader/src/modules/settings/state/language_state.dart';
import 'package:wisy_image_uploader/src/modules/settings/widgets/language_selector_widget.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(userLanguageCodeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: LanguageSelector(key: ValueKey('key-$languageCode')),
      ),
    );
  }
}

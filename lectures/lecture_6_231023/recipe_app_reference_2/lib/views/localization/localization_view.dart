import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:recipe_app/views/provider_example/provider_example.dart';

class LocalizationView extends StatelessWidget {
  const LocalizationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Locale selectedLocale = Localizations.localeOf(context);
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(selectedLocale.languageCode),
              TextButton(
                child: const Text("show date picker"),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365)));
                },
              ),
              // dropdown applocalizations countrycodes

              DropdownButton<String>(
                  value: selectedLocale.languageCode,
                  items: AppLocalizations.supportedLocales
                      .map((e) => DropdownMenuItem(
                          value: e.languageCode, child: Text(e.languageCode)))
                      .toList(),
                  onChanged: (country) {
                    context.read<ValueNotifier<Locale>>().value =
                        Locale(country!);
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "providerExample",
          label: const Text("Provider Example"),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProviderExample()));
          },
        ));
  }
}

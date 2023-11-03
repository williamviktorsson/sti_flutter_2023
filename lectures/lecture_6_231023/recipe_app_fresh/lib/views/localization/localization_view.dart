import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocalizationView extends StatelessWidget {
  const LocalizationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Locale> selectedLocale =
        context.watch<ValueNotifier<Locale>>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(selectedLocale.value.languageCode),
          TextButton(
            child: Text("show date picker"),
            onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365)));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("${selectedLocale.value.countryCode}"),
        onPressed: () {
          if (selectedLocale.value.countryCode == "SE") {
            selectedLocale.value = const Locale("en", "US");
          } else {
            selectedLocale.value = const Locale("sv", "SE");
          }
        },
      ),
    );
  }
}

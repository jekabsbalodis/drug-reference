import 'package:drug_reference/constants.dart';
import 'package:drug_reference/models/medication.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key, required this.searchResult});

  final Medication searchResult;

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(
        'https://www.antidopings.gov.lv/lv/darbinieki?items_per_page=20&position%5B120%5D=120&position%5B123%5D=123');

    Future<void> openUrl() async {
      if (!await launchUrl(url)) {
        throw Exception('Nevarēja atvērt adresi $url');
      }
    }

    TextStyle textStyleMedium = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.onSurface);

    TextStyle textStyleLarge = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Theme.of(context).colorScheme.onSurface);

    Widget information = Text(
      'Aizliegts sacensībās: ${searchResult.prohibitedInComp}\n'
      'Aizliegts ārpus sacensībām: ${searchResult.prohibitedOutComp}',
      style: textStyleLarge,
    );

    if (searchResult.prohibitedInComp.isEmpty) {
      information = Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Center(
          child: Text.rich(
            TextSpan(
              style: textStyleLarge,
              children: [
                TextSpan(text: noInformation[0]),
                TextSpan(
                    text: noInformation[1],
                    style: textStyleLarge.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Theme.of(context).colorScheme.onSurface,
                        color: Theme.of(context).colorScheme.onSurface),
                    recognizer: TapGestureRecognizer()..onTap = openUrl),
                TextSpan(
                  text: termsPrompt[2],
                  style: textStyleLarge,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(searchResult.shortName),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${searchResult.shortName} ${searchResult.formattedForm}',
                  style: textStyleMedium,
                ),
                Text(
                  searchResult.substance,
                  style: textStyleMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Reģistrācijas numurs: ${searchResult.regNo}',
                  style: textStyleMedium,
                ),
                const Divider(),
                information,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

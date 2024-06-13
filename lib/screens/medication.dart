import 'package:drug_reference/constants.dart';
import 'package:drug_reference/models/medication.dart';
import 'package:drug_reference/widgets/medication_information_in_comp.dart';
import 'package:drug_reference/widgets/medication_information_out_comp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({
    super.key,
    required this.searchResult,
    required this.isScreen,
  });

  final Medication searchResult;
  final bool isScreen;

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(const String.fromEnvironment('ANTIDOPING_URL'));

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

    TextStyle textStyleSmall = Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(color: Theme.of(context).colorScheme.onSurface);

    List<Widget> information = [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MedicationInformationInCompetion(searchResult: searchResult),
          MedicationInformationOutCompetion(searchResult: searchResult),
        ],
      ),
      const SizedBox(height: 8),
      if (searchResult.prohibitedClass.isNotEmpty)
        Text(
          'Aizliegto vielu un metožu saraksta klase: ${searchResult.prohibitedClass}',
          style: textStyleMedium,
        ),
      const SizedBox(height: 8),
      if (searchResult.notes.isNotEmpty)
        Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.warning,
                    color: Colors.amber,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        searchResult.notes,
                        style: textStyleMedium,
                        softWrap: true,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      const SizedBox(height: 16),
      const Divider(),
      if (searchResult.prohibitedSportsInComp.isNotEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Sporta veidi, kuros aizliegts sacensību laikā:',
              style: textStyleMedium,
              softWrap: true,
            ),
            const SizedBox(height: 4),
            Text(
              searchResult.prohibitedSportsInComp,
              style: textStyleSmall,
              softWrap: true,
            ),
            const SizedBox(height: 8),
          ],
        ),
      if (searchResult.prohibitedSportsOutComp.isNotEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sporta veidi, kuros aizliegts ārpus sacensību laika:',
              style: textStyleMedium,
              softWrap: true,
            ),
            const SizedBox(height: 4),
            Text(
              searchResult.prohibitedSportsOutComp,
              style: textStyleSmall,
              softWrap: true,
            ),
          ],
        ),
    ];

    if (searchResult.prohibitedInComp.isEmpty) {
      information = [
        const SizedBox(height: 16),
        Center(
          child: Text.rich(
            TextSpan(
              style: textStyleLarge,
              children: [
                TextSpan(text: noInformation[0]),
                WidgetSpan(
                  child: TextButton(
                    onPressed: openUrl,
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      noInformation[1],
                      style: textStyleLarge.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.onSurface,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
                TextSpan(
                  text: termsPrompt[2],
                  style: textStyleLarge,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ];
    }

    if (isScreen) {
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
                    '${searchResult.shortName}|${searchResult.formattedForm}',
                    style: textStyleMedium,
                  ),
                  Text(
                    searchResult.substance,
                    style:
                        textStyleMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (searchResult.strength.isNotEmpty)
                    Text(
                      'Medikamenta deva: ${searchResult.strength}',
                      style: textStyleMedium,
                    ),
                  Text(
                    'Reģistrācijas numurs: ${searchResult.regNo}',
                    style: textStyleMedium,
                  ),
                  const Divider(),
                  ...information,
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${searchResult.shortName}|${searchResult.formattedForm}',
                  style: textStyleMedium,
                ),
                Text(
                  searchResult.substance,
                  style: textStyleMedium.copyWith(fontWeight: FontWeight.bold),
                ),
                if (searchResult.strength.isNotEmpty)
                  Text(
                    'Medikamenta deva: ${searchResult.strength}',
                    style: textStyleMedium,
                  ),
                Text(
                  'Reģistrācijas numurs: ${searchResult.regNo}',
                  style: textStyleMedium,
                ),
                const Divider(),
                ...information,
              ],
            ),
          ),
        ),
      );
    }
  }
}

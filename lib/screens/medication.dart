import 'package:drug_reference/models/medication.dart';
import 'package:flutter/material.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key, required this.searchResult});

  final Medication searchResult;

  @override
  Widget build(BuildContext context) {
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
                  '${searchResult.shortName} ${searchResult.formattedForm}\n'
                  '${searchResult.substance}\n'
                  'Reģistrācijas numurs: ${searchResult.regNo}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                if (searchResult.prohibitedInComp!.isNotEmpty)
                  Text(searchResult.prohibitedInComp!)
                else const Text('no data'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

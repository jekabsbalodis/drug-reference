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
        body: Center(
          child: Text(searchResult.substance),
        ),
      ),
    );
  }
}

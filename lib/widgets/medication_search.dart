import 'package:flutter/material.dart';

class MedicationSearch extends StatefulWidget {
  const MedicationSearch({
    super.key,
  });

  @override
  State<MedicationSearch> createState() => _MedicationSearchState();
}

class _MedicationSearchState extends State<MedicationSearch> {
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: const Column(children: [Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Expanded(child: TextField())],
        )],),
      ),
    );
  }
}

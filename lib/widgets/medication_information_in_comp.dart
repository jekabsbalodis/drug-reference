import 'package:drug_reference/models/medication.dart';
import 'package:drug_reference/widgets/information_card.dart';
import 'package:flutter/material.dart';

class MedicationInformationInCompetion extends StatelessWidget {
  const MedicationInformationInCompetion(
      {super.key, required this.searchResult});

  final Medication searchResult;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromRGBO(244, 67, 54, 1);
    Color textColor = const Color.fromRGBO(33, 18, 20, 1);
    if (searchResult.prohibitedInComp == 'Jā*') {
      backgroundColor = const Color.fromRGBO(255, 103, 92, 1);
    } else if (searchResult.prohibitedInComp == 'Ar nosacījumu') {
      backgroundColor = const Color.fromRGBO(255, 193, 7, 1);
    } else if (searchResult.prohibitedInComp == 'Nē') {
      backgroundColor = const Color.fromRGBO(139, 195, 74, 1);
    }
    final String cardText;
    switch (searchResult.prohibitedInComp) {
      case 'Jā':
        cardText = 'Sacensību laikā\nAizliegts';
      case 'Jā*':
        cardText = 'Sacensību laikā\nAizliegts noteiktos sporta veidos';
      case 'Ar nosacījumu':
        cardText = 'Sacensību laikā\nAtļauts noteiktos gadījumos';
      case 'Nē':
        cardText = 'Sacensību laikā\nAtļauts';
      default:
        cardText = 'Sacensību laikā\nAizliegts';
    }

    return InformationCard(
        backgroundColor: backgroundColor,
        cardText: cardText,
        textColor: textColor);
  }
}

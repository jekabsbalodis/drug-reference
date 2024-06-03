import 'package:drug_reference/models/medication.dart';
import 'package:drug_reference/widgets/information_card.dart';
import 'package:flutter/material.dart';

class MedicationInformationOutCompetion extends StatelessWidget {
  const MedicationInformationOutCompetion(
      {super.key, required this.searchResult});

  final Medication searchResult;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color.fromRGBO(244, 67, 54, 1);
    Color textColor = const Color.fromRGBO(33, 18, 20, 1);
    if (searchResult.prohibitedOutComp == 'Jā*') {
      backgroundColor = const Color.fromRGBO(255, 103, 92, 1);
    } else if (searchResult.prohibitedOutComp == 'Ar nosacījumu') {
      backgroundColor = const Color.fromRGBO(255, 193, 7, 1);
    } else if (searchResult.prohibitedOutComp == 'Nē') {
      backgroundColor = const Color.fromRGBO(139, 195, 74, 1);
    }
    final String cardText;
    switch (searchResult.prohibitedOutComp) {
      case 'Jā':
        cardText = 'Ārpus sacensībām\nAizliegts';
      case 'Jā*':
        cardText = 'Ārpus sacensībām\nAizliegts noteiktos sporta veidos';
      case 'Ar nosacījumu':
        cardText = 'Ārpus sacensībām\nAtļauts noteiktos gadījumos';
      case 'Nē':
        cardText = 'Ārpus sacensībām\nAtļauts';
      default:
        cardText = 'Ārpus sacensībām\nAizliegts';
    }

    return InformationCard(
        backgroundColor: backgroundColor,
        cardText: cardText,
        textColor: textColor);
  }
}

import 'package:flutter/material.dart';

enum SearchMode { name, activeSubstance, regNo }

class SearchModeButton extends StatefulWidget {
  const SearchModeButton({super.key, required this.onSetSearchMode});

  final Function(SearchMode mode) onSetSearchMode;

  @override
  State<SearchModeButton> createState() => _SearchModeButtonState();
}

class _SearchModeButtonState extends State<SearchModeButton> {
  SearchMode searchModeView = SearchMode.activeSubstance;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SearchMode>(
      segments: const <ButtonSegment<SearchMode>>[
        ButtonSegment<SearchMode>(
          value: SearchMode.activeSubstance,
          label: Text('Viela'),
        ),
        ButtonSegment<SearchMode>(
          value: SearchMode.name,
          label: Text('Medikaments'),
        ),
        ButtonSegment<SearchMode>(
          value: SearchMode.regNo,
          label: Text('Numurs'),
        ),
      ],
      selected: <SearchMode>{searchModeView},
      onSelectionChanged: (Set<SearchMode> newSelection) {
        setState(() {
          searchModeView = newSelection.first;
        });
        widget.onSetSearchMode(searchModeView);
      },
      showSelectedIcon: false,
    );
  }
}

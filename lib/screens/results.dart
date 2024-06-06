import 'package:drug_reference/constants.dart';
import 'package:drug_reference/models/medication.dart';
import 'package:drug_reference/screens/medication.dart';
import 'package:drug_reference/widgets/medication_search.dart';
import 'package:drug_reference/widgets/search_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen(
      {super.key,
      required this.supabase,
      required this.searchMode,
      required this.searchTerm,
      required this.termsAccepted});

  final SupabaseClient supabase;
  final SearchMode searchMode;
  final String searchTerm;
  final bool termsAccepted;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late String _searchTerm;
  late SearchMode _searchMode;
  Widget _selectedResult = const Text('Izvēlies medikamentu no saraksta');
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchTerm = widget.searchTerm;
    _searchMode = widget.searchMode;
  }

  Future<List<Medication>> searchResults(
      SearchMode searchMode, String searchTerm) async {
    final String searchFunction;
    switch (searchMode) {
      case SearchMode.name:
        searchFunction = 'fuzzy_search';
      case SearchMode.activeSubstance:
        searchFunction = 'fuzzy_search_active_substance';
      case SearchMode.regNo:
        searchFunction = 'fuzzy_search_reg_no';
    }
    final data = await widget.supabase
        .rpc(searchFunction, params: {'search_term': searchTerm}).select('*');
    final dataParsed =
        data.map<Medication>((item) => Medication.fromSupabase(item)).toList();
    return dataParsed;
  }

  void _newSearch() {
    if (widget.termsAccepted == false) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Jāapstiprina noteikumi')));
    } else {
      showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context,
          builder: (ctx) =>
              MedicationSearch(onEnterSearchTerm: _submitNewSearchTerm));
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitNewSearchTerm(String searchTerm, SearchMode searchMode) {
    setState(() {
      _searchTerm = searchTerm;
      _searchMode = searchMode;
      searchResults(_searchMode, _searchTerm);
      _selectedResult = const Text('Izvēlies medikamentu no saraksta');
    });
    _scrollToTop();
  }

  void _selectMedicationNewScreen(
      BuildContext context, Medication searchResult) {
    Medication selectedMedication = searchResult;
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return MedicationScreen(
          searchResult: selectedMedication,
          isScreen: true,
        );
      },
    ));
  }

  void _selectMedicationSameScreen(Medication searchResult) {
    setState(() {
      _selectedResult = MedicationScreen(
        searchResult: searchResult,
        isScreen: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      if (width < 600) {
        return SelectionArea(
          child: Scaffold(
            appBar: AppBar(title: const Text('Medikamentu references')),
            body: FutureBuilder(
              future: searchResults(_searchMode, _searchTerm),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final searchResults = snapshot.data!;
                if (searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      emptyResults,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: searchResults.length,
                  itemBuilder: ((context, index) {
                    final searchResult = searchResults[index];
                    Widget titleText;
                    if (searchResult.strength.isEmpty) {
                      titleText = Text(searchResult.shortName);
                    } else {
                      titleText = Text(
                          '${searchResult.shortName}|${searchResult.strength}');
                    }
                    Widget subtitleText =
                        Text('${searchResult.substance}\n${searchResult.form}');
                    return Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: titleText,
                        subtitle: subtitleText,
                        onTap: () =>
                            _selectMedicationNewScreen(context, searchResult),
                      ),
                    );
                  }),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _newSearch,
              child: const Icon(Icons.search),
            ),
          ),
        );
      } else {
        return SelectionArea(
          child: Scaffold(
            appBar: AppBar(title: const Text('Medikamentu references')),
            body: FutureBuilder(
              future: searchResults(_searchMode, _searchTerm),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final searchResults = snapshot.data!;
                if (searchResults.isEmpty) {
                  return Center(
                    child: Text(
                      emptyResults,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: searchResults.length,
                        itemBuilder: ((context, index) {
                          final searchResult = searchResults[index];
                          Widget titleText;
                          if (searchResult.strength.isEmpty) {
                            titleText = Text(searchResult.shortName);
                          } else {
                            titleText = Text(
                                '${searchResult.shortName}|${searchResult.strength}');
                          }
                          Widget subtitleText = Text(
                              '${searchResult.substance}\n${searchResult.form}');
                          return Card(
                              child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            title: titleText,
                            subtitle: subtitleText,
                            onTap: () =>
                                _selectMedicationSameScreen(searchResult),
                          ));
                        }),
                      ),
                    ),
                    const VerticalDivider(),
                    Flexible(
                      flex: 2,
                      child: Center(child: _selectedResult),
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _newSearch,
              child: const Icon(Icons.search),
            ),
          ),
        );
      }
    });
  }
}

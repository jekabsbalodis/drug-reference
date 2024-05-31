import 'package:drug_reference/constants.dart';
import 'package:drug_reference/models/medication.dart';
import 'package:drug_reference/screens/medication.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.supabase,
    required this.searchFunction,
    required this.searchTerm,
    required this.onActionButtonPress,
  });

  final SupabaseClient supabase;
  final String searchFunction;
  final String searchTerm;
  final void Function() onActionButtonPress;

  Future<List<Medication>> searchResults(String searchMode, String term) async {
    final data = await supabase
        .rpc(searchMode, params: {'search_term': term}).select('*');
    final dataParsed =
        data.map<Medication>((item) => Medication.fromSupabase(item)).toList();
    return dataParsed;
  }

  void _selectMedication(BuildContext context, Medication searchResult) {
    Medication selectedMedication = searchResult;
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return MedicationScreen(
          searchResult: selectedMedication,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Medikamentu references')),
        body: FutureBuilder(
          future: searchResults(searchFunction, searchTerm),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final searchResults = snapshot.data!;
            if (searchResults.isEmpty) {
              return Center(
                child: Text(
                  emptyResults,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: ((context, index) {
                final searchResult = searchResults[index];
                return ListTile(
                  title: Text(searchResult.shortName),
                  subtitle: Text(searchResult.substance),
                  onTap: () => _selectMedication(context, searchResult),
                );
              }),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onActionButtonPress,
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}

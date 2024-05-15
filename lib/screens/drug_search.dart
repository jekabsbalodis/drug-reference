import 'package:drug_reference/models/medication.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({super.key, required this.supabase});

  final SupabaseClient supabase;

  Future<List<Medication>> resultsList() async {
    // final data = await supabase
    //     .from('drug_reference')
    //     .select()
    //     .ilike('short_name', 'ibumet%')
    //     .limit(10);
    // return data;
    final data = await supabase
        .rpc('fuzzy_search', params: {'search_term': 'krka'}).select('*').limit(5);
    // final data = await supabase.from('drug_reference').select().textSearch('active_substance', 'Tramadol');
    return data
        .map<Medication>((item) => Medication.fromSupabase(item))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medikamentu references')),
      body: FutureBuilder(
        future: resultsList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final results = snapshot.data!;
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: ((context, index) {
              final result = results[index];
              return ListTile(
                title: Text(result.shortName),
                subtitle: Text(result.regNo),
              );
            }),
          );
        },
      ),
    );
  }
}

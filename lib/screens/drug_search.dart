import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrugSearchScreen extends StatelessWidget {
  const DrugSearchScreen({super.key, required this.supabase});

  final SupabaseClient supabase;

  Future<List<Map<String, dynamic>>> fetchData() async {
    // final data = await supabase
    //     .from('drug_reference')
    //     .select()
    //     .ilike('short_name', 'ibumet%')
    //     .limit(10);
    // return data;
    final data = await supabase
        .rpc('fuzzy_search', params: {'search_term': 'tramadols'}).select('*');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Medikamentu references')),
      body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final meds = snapshot.data!;
            return ListView.builder(
                itemCount: meds.length,
                itemBuilder: ((context, index) {
                  final med = meds[index];
                  return ListTile(
                    title: Text(med['authorisation_no']),
                    subtitle: Text(med['medicine_name']),
                  );
                }));
          },
        )));
  }
}

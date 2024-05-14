import 'package:drug_reference/screens/drug_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(229, 114, 0, 1),
    brightness: Brightness.light,
  ),
  textTheme: GoogleFonts.cousineTextTheme(),
);
final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(139, 70, 0, 1),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.cousineTextTheme(),
);

const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final _supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      darkTheme: darkTheme,
      home: DrugSearchScreen(supabase: _supabase,),
    );
  }
}

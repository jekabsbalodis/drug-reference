import 'package:drug_reference/constants.dart';
import 'package:drug_reference/models/medication.dart';
import 'package:drug_reference/screens/medication.dart';
import 'package:drug_reference/widgets/accept_terms_alert.dart';
import 'package:drug_reference/widgets/accept_terms_checkbox.dart';
import 'package:drug_reference/widgets/medication_search.dart';
import 'package:drug_reference/widgets/search_mode_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DrugReference extends StatefulWidget {
  const DrugReference({super.key, required this.supabase});

  final SupabaseClient supabase;

  @override
  State<DrugReference> createState() => _DrugReferenceState();
}

class _DrugReferenceState extends State<DrugReference>
    with TickerProviderStateMixin {
  bool _isAccepted = false;
  late AnimationController _animationController;
  List<Medication> results = [];
  List<String> searchTerms = [];

  void _openTermsScreen() {
    showDialog(
        context: context,
        builder: ((context) {
          return const AcceptTermsAlert();
        })).then(
      (value) {
        if (value != null) {
          _setCheckboxValue(value);
        }
      },
    );
  }

  void _openSearchScreen() {
    if (_isAccepted == false) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Jāapstiprina noteikumi')));
      _animationController.forward();
    } else {
      showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context,
          builder: (ctx) =>
              MedicationSearch(onEnterSearchTerm: _submitSearchTerm));
    }
  }

  void _submitSearchTerm(String searchTerm, SearchMode searchMode) async {
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
    setState(() {
      results = data
          .map<Medication>((item) => Medication.fromSupabase(item))
          .toList();
      searchTerms.add(searchTerm);
    });
  }

  void _selectMedicationScreen(BuildContext context, Medication result) {
    Medication medication = result;
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return MedicationScreen(
          searchResult: medication,
        );
      },
    ));
  }

  void _setCheckboxValue(bool checkboxState) {
    setState(() {
      _isAccepted = checkboxState;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = ListView.builder(
      itemCount: results.length,
      itemBuilder: ((context, index) {
        final result = results[index];
        return ListTile(
          title: Text(result.shortName),
          subtitle: Text(result.substance),
          onTap: () => _selectMedicationScreen(context, result),
        );
      }),
    );

    if (results.isEmpty & searchTerms.isNotEmpty) {
      mainContent = Center(
        child: Text(
          emptyResults,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
      );
    } else if (results.isEmpty & searchTerms.isEmpty) {
      mainContent = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          FilledButton(
              onPressed: () => _openSearchScreen(),
              child: const Text('Meklēt medikamentus')),
          const SizedBox(height: 48),
          Text.rich(
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
              children: [
                TextSpan(text: termsPrompt[0]),
                TextSpan(
                    text: termsPrompt[1],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Theme.of(context).colorScheme.onSurface,
                        color: Theme.of(context).colorScheme.onSurface),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => _openTermsScreen()),
                TextSpan(
                    text: termsPrompt[2],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
              ],
            ),
          )
              .animate(
                autoPlay: false,
                controller: _animationController,
              )
              .shake(),
          const SizedBox(height: 24),
          AcceptTermsCheckbox(
            checkboxState: _isAccepted,
            onCheckboxPress: _setCheckboxValue,
          ),
          const SizedBox(height: 40),
        ],
      );
    }

    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pārbaudīt medikamentu'),
          actions: [
            IconButton(
                onPressed: () => _openSearchScreen(),
                icon: const Icon(Icons.search))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: mainContent,
        ),
      ),
    );
  }
}

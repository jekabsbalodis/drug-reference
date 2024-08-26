import 'package:drug_reference/constants.dart';
import 'package:drug_reference/main.dart';
import 'package:drug_reference/models/medication.dart';
import 'package:drug_reference/screens/results.dart';
import 'package:drug_reference/widgets/accept_terms_alert.dart';
import 'package:drug_reference/widgets/accept_terms_checkbox.dart';
import 'package:drug_reference/widgets/medication_search.dart';
import 'package:drug_reference/widgets/search_mode_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  bool _isAccepted = false;
  late AnimationController _animationController;
  List<Medication> searchResults = [];
  List<String> searchTerms = [];
  final Uri url = Uri.parse(
      Uri.decodeFull(const String.fromEnvironment('ACCESSIBILITY_NOTICE')));

  Future<void> openUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Nevarēja atvērt adresi $url');
    }
  }

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

  void _setCheckboxValue(bool checkboxState) {
    setState(() {
      _isAccepted = checkboxState;
    });
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

  void _submitSearchTerm(String searchTerm, SearchMode searchMode) {
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return ResultsScreen(
          supabase: App.supabase,
          searchMode: searchMode,
          searchTerm: searchTerm,
          termsAccepted: _isAccepted,
        );
      },
    ));
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
    Text appBarTitle = const Text('Medikamentu pārbaude');
    Widget mainContent = Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Spacer(),
          FilledButton(
              onPressed: () => _openSearchScreen(),
              child: const Text('Meklēt medikamentus')),
          const SizedBox(height: 48),
          Text.rich(
            textAlign: TextAlign.center,
            softWrap: true,
            TextSpan(
              children: [
                TextSpan(
                  text: termsPrompt[0],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                WidgetSpan(
                  child: TextButton(
                    onPressed: _openTermsScreen,
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      termsPrompt[1],
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                Theme.of(context).colorScheme.onSurface,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  )
                      .animate(
                        autoPlay: false,
                        controller: _animationController,
                      )
                      .shake(),
                ),
                TextSpan(
                  text: termsPrompt[2],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AcceptTermsCheckbox(
            checkboxState: _isAccepted,
            onCheckboxPress: _setCheckboxValue,
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: openUrl,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              accessibilityNotice,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.onSurface,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      if (width < 600) {
        return SelectionArea(
          child: Scaffold(
            appBar: AppBar(title: appBarTitle),
            body: mainContent,
          ),
        );
      } else {
        return SelectionArea(
          child: Scaffold(
            appBar: AppBar(
                title: Align(
                    alignment: Alignment.center,
                    child: SizedBox(width: 600, child: appBarTitle))),
            body: Align(
                alignment: Alignment.center,
                child: SizedBox(width: 600, child: mainContent)),
          ),
        );
      }
    });
  }
}

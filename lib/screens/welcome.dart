import 'package:drug_reference/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/accept_terms_alert.dart';
import '../widgets/accept_terms_dialog.dart';
import '../widgets/medication_search.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isAccepted = false;

  void _openTermsScreen() {
    showDialog(
      context: context,
      builder: ((context) {
        return const AcceptTermsDialog();
      }),
    ).then(
      (value) {
        if (value != null) {
          setState(() {
            _isAccepted = value;
          });
        }
      },
    );
  }

  void _openSearchScreen() {
    if (_isAccepted == false) {
      showDialog(
        context: context,
        builder: (context) {
          return const AcceptTermsAlert();
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return const MedicationSearch();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pārbaudīt medikamentu'),
          actions: [
            IconButton(
                onPressed: () {
                  _openSearchScreen();
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              FilledButton(
                  onPressed: () {
                    _openSearchScreen();
                  },
                  child: const Text('Meklēt medikamentus')),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                    children: [
                      TextSpan(text: termsPrompt[0]),
                      TextSpan(
                          text: termsPrompt[1],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Theme.of(context).colorScheme.onSurface,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _openTermsScreen();
                            }),
                      TextSpan(
                          text: termsPrompt[2],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Checkbox(
                        value: _isAccepted,
                        onChanged: (newValue) {
                          setState(() => _isAccepted = newValue!);
                        }),
                  ),
                  Flexible(
                    child: Text(
                      acceptTerms,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

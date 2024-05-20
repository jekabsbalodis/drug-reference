import 'package:drug_reference/constants.dart';
import 'package:drug_reference/widgets/accept_terms.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _openTermsScreen() {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              content: const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(appUsageTerms),
                ),
              ),
              actions: [TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Atcelt')),
                        FilledButton(
                        onPressed: () {
                          ;
                        },
                        child: const Text('Atcelt'))],
            )));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pārbaudīt medikamentu'),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              FilledButton(
                  onPressed: () {}, child: const Text('Meklēt medikamentus')),
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
                          ..onTap = () {
                            _openTermsScreen();
                          }),
                    TextSpan(
                        text: termsPrompt[2],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const AcceptTerms(text: acceptTerms),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}

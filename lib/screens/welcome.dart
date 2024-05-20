import 'package:drug_reference/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
        return AlertDialog(
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                appUsageTerms,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Atcelt')),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Piekrist noteikumiem'))
          ],
        );
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: _isAccepted,
                      onChanged: (newValue) {
                        setState(() => _isAccepted = newValue!);
                      }),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      acceptTerms,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}

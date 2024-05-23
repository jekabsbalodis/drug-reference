import 'package:drug_reference/constants.dart';
import 'package:flutter/material.dart';

class AcceptTermsAlert extends StatelessWidget {
  const AcceptTermsAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                ))),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Atcelt')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Apstiprināt'))
        ]);
  }
}

import 'package:flutter/material.dart';

class AcceptTermsAlert extends StatelessWidget {
  const AcceptTermsAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Nav apstiprināti noteikumi',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      content: Text(
        'Lai izmantotu lietotni, jāapstiprina tās noteikumi',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Labi')),
      ],
    );
  }
}

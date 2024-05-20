import 'package:flutter/material.dart';

class AcceptTerms extends StatefulWidget {
  const AcceptTerms({super.key, required this.text});

  final String text;

  @override
  State<AcceptTerms> createState() => _AcceptTermsState();
}

class _AcceptTermsState extends State<AcceptTerms> {
  var _accepted = false;  

  void _setAccepted(bool? isChecked) {
    setState(() {
      _accepted = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(value: _accepted, onChanged: _setAccepted),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            widget.text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface)
          ),
        ),
      ],
    );
  }
}

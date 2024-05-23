import 'package:drug_reference/constants.dart';
import 'package:flutter/material.dart';

class AcceptTermsCheckbox extends StatefulWidget {
  const AcceptTermsCheckbox({super.key, required this.checkboxState, required this.onCheckboxPress});

  final bool checkboxState;
  final Function(bool checkboxState) onCheckboxPress;

  @override
  State<AcceptTermsCheckbox> createState() => _AcceptTermsCheckboxState();
}

class _AcceptTermsCheckboxState extends State<AcceptTermsCheckbox> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width > 600)
            ? 600
            : MediaQuery.of(context).size.width,
        child: CheckboxListTile(
          title: Text(
            acceptTerms,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          value: widget.checkboxState,
          onChanged: (newValue) => setState(() => widget.onCheckboxPress(newValue!)),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}

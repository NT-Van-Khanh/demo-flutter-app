import 'package:b1_first_flutter_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final void Function(String value) onSearchSubmitted;

  const SearchField({
    super.key,
    required this.onSearchSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 18
      ),
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.weather_searchLocationLabel,
        hintText: AppLocalizations.of(context)!.weather_searchLocationHint,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.w600
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        suffixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none)
        ),
        onSubmitted: onSearchSubmitted,
    );
  }
}

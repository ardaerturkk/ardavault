import 'package:flutter/cupertino.dart';
import 'package:flutter/semantics.dart';

import '../model/book.dart';
import '../model/content.dart';
import 'names.dart';
import 'widgets.dart';

/// The language of every German line, so VoiceOver reads it with a German
/// voice whatever the UI language is.
const germanLocale = Locale('de', 'DE');

/// Semantics label for a German line followed by its meaning: the German
/// part is marked as German.
AttributedString germanLabel(String german, String meaning) => AttributedString(
  meaning.isEmpty ? german : '$german\n$meaning',
  attributes: [
    LocaleStringAttribute(
      range: TextRange(start: 0, end: german.length),
      locale: germanLocale,
    ),
  ],
);

/// Rich text for a filled line. The user's own details are highlighted;
/// missing ones show their label in brackets.
List<InlineSpan> lineSpans(
  BuildContext context,
  List<Piece> pieces,
  Situation situation, {
  Color? filledColor,
  FontWeight filledWeight = FontWeight.w600,
}) {
  final l = context.l;
  final missing = CupertinoColors.secondaryLabel.resolveFrom(context);
  return [
    for (final p in pieces)
      if (!p.isSlot)
        TextSpan(text: p.text)
      else if (p.isMissing)
        TextSpan(
          text: '[${slotLabel(l, p.slot!, situation)}]',
          style: TextStyle(color: missing),
        )
      else
        TextSpan(
          text: p.text,
          style: TextStyle(color: filledColor, fontWeight: filledWeight),
        ),
  ];
}

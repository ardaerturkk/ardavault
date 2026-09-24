import 'package:flutter/cupertino.dart';

import '../model/book.dart';
import '../model/content.dart';
import 'names.dart';
import 'widgets.dart';

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

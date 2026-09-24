import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/content.dart';
import '../state/app_state.dart';
import 'line_text.dart';
import 'names.dart';
import 'widgets.dart';

/// Opens the large-type cards of a situation at one line.
Future<void> openCards(
  BuildContext context, {
  required Situation situation,
  required int index,
}) => Navigator.of(context, rootNavigator: true).push(
  CupertinoPageRoute<void>(
    fullscreenDialog: true,
    builder: (_) => CardPage(situationId: situation.id, initialIndex: index),
  ),
);

class CardPage extends StatefulWidget {
  const CardPage({super.key, required this.situationId, this.initialIndex = 0});
  final String situationId;
  final int initialIndex;

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late final _pages = PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;
  int? _copied;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _go(int to) {
    unawaited(
      _pages.animateToPage(
        to,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final book = AppScope.of(context).book;
    final s = situationById(widget.situationId)!;
    final lines = book.linesFor(s, meaningLocale(l));
    if (lines.isEmpty) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
            child: Text(l.done),
          ),
        ),
        child: const SizedBox.shrink(),
      );
    }
    final index = math.min(_index, lines.length - 1);
    final copied = _copied == index;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBackground,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Text(
            l.done,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        middle: Text(s.german),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            final text = plainText(l, book.fill(lines[index].german, s.id), s);
            unawaited(Clipboard.setData(ClipboardData(text: text)));
            unawaited(HapticFeedback.lightImpact());
            setState(() => _copied = index);
          },
          child: Text(copied ? l.copied : l.copy),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pages,
                itemCount: lines.length,
                onPageChanged: (i) {
                  unawaited(HapticFeedback.selectionClick());
                  setState(() => _index = i);
                },
                itemBuilder: (context, i) => _Card(
                  situation: s,
                  german: lines[i].german,
                  meaning: lines[i].meaning,
                ),
              ),
            ),
            _Pager(
              index: index,
              total: lines.length,
              onPrevious: index > 0 ? () => _go(index - 1) : null,
              onNext: index < lines.length - 1 ? () => _go(index + 1) : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// One line in the largest type that fits the screen.
class _Card extends StatelessWidget {
  const _Card({
    required this.situation,
    required this.german,
    required this.meaning,
  });
  final Situation situation;
  final String german;
  final String meaning;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final book = AppScope.of(context).book;
    final theme = CupertinoTheme.of(context).textTheme;
    final label = CupertinoColors.label.resolveFrom(context);
    final pieces = book.fill(german, situation.id);
    final spans = lineSpans(
      context,
      pieces,
      situation,
      filledWeight: FontWeight.w700,
    );
    final meaningText = meaning.isEmpty
        ? ''
        : plainText(
            l,
            book.fill(meaning, situation.id, numeric: true),
            situation,
          );
    final scaler = MediaQuery.textScalerOf(context)
        .clamp(minScaleFactor: 1, maxScaleFactor: 2);
    const pad = EdgeInsets.fromLTRB(24, 16, 24, 16);

    return LayoutBuilder(
      builder: (context, box) {
        final width = box.maxWidth - pad.horizontal;
        final height = box.maxHeight - pad.vertical;
        TextStyle germanStyle(double size) => theme.textStyle.copyWith(
          fontSize: size,
          height: 1.2,
          fontWeight: FontWeight.w600,
          color: label,
          letterSpacing: 0,
        );
        // The meaning stays clearly smaller than the German line.
        TextStyle meaningStyle(double germanSize) => theme.textStyle.copyWith(
          fontSize: math.max(15, math.min(scaler.scale(19), germanSize * 0.6)),
          height: 1.3,
          color: CupertinoColors.secondaryLabel.resolveFrom(context),
        );
        double measure(TextSpan span) {
          final p = TextPainter(
            text: span,
            textDirection: Directionality.of(context),
          )..layout(maxWidth: width);
          final h = p.height;
          p.dispose();
          return h;
        }

        double meaningHeight(double germanSize) => meaningText.isEmpty
            ? 0.0
            : 24 +
                  measure(
                    TextSpan(
                      text: meaningText,
                      style: meaningStyle(germanSize),
                    ),
                  );
        // Largest size that fits, with no word wider than the screen. At
        // big text settings start larger; fall back to smaller sizes for
        // very long words.
        final top = math.min(scaler.scale(56), 72.0);
        final sizes = [for (var f = top; f >= 24; f -= 4) f];
        final words = plainText(l, pieces, situation).split(RegExp(r'\s+'));
        bool wordsFit(double f) {
          for (final w in words) {
            final p = TextPainter(
              text: TextSpan(text: w, style: germanStyle(f)),
              textDirection: Directionality.of(context),
              maxLines: 1,
            )..layout();
            final wide = p.width > width;
            p.dispose();
            if (wide) return false;
          }
          return true;
        }

        final readable = [
          for (final f in sizes)
            if (wordsFit(f)) f,
        ];
        final floor = math.min(scaler.scale(28), 72.0);
        // Too long for one screen: the smallest size that still respects
        // the text setting, and the card scrolls.
        var size = readable.lastWhere(
          (f) => f >= floor,
          orElse: () => readable.isEmpty ? sizes.last : readable.last,
        );
        for (final f in readable) {
          final h = measure(TextSpan(style: germanStyle(f), children: spans));
          if (h + meaningHeight(f) <= height) {
            size = f;
            break;
          }
        }
        return SingleChildScrollView(
          padding: pad,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: math.max(0.0, height)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(children: spans),
                  textScaler: TextScaler.noScaling,
                  style: germanStyle(size),
                ),
                if (meaningText.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    meaningText,
                    textScaler: TextScaler.noScaling,
                    style: meaningStyle(size),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Pager extends StatelessWidget {
  const _Pager({
    required this.index,
    required this.total,
    required this.onPrevious,
    required this.onNext,
  });
  final int index;
  final int total;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Row(
        children: [
          CupertinoButton(
            minimumSize: const Size(44, 44),
            onPressed: onPrevious,
            child: Icon(
              CupertinoIcons.chevron_left,
              semanticLabel: l.previousLine,
            ),
          ),
          Expanded(
            child: Text(
              l.cardOf(index + 1, total),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFeatures: const [FontFeature.tabularFigures()],
                color: CupertinoColors.secondaryLabel.resolveFrom(context),
              ),
            ),
          ),
          CupertinoButton(
            minimumSize: const Size(44, 44),
            onPressed: onNext,
            child: Icon(
              CupertinoIcons.chevron_right,
              semanticLabel: l.nextLine,
            ),
          ),
        ],
      ),
    );
  }
}

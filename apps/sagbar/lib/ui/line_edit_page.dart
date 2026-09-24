import 'package:flutter/cupertino.dart';

import '../model/book.dart';
import '../model/content.dart';
import '../state/app_state.dart';
import 'widgets.dart';

/// Opens the editor for a line of your own as a full-screen sheet.
Future<void> openLineEditor(
  BuildContext context, {
  required Situation situation,
  CustomLine? line,
}) => Navigator.of(context, rootNavigator: true).push(
  CupertinoPageRoute<void>(
    fullscreenDialog: true,
    builder: (_) => LineEditPage(situation: situation, line: line),
  ),
);

class LineEditPage extends StatefulWidget {
  const LineEditPage({super.key, required this.situation, this.line});
  final Situation situation;
  final CustomLine? line;

  @override
  State<LineEditPage> createState() => _LineEditPageState();
}

class _LineEditPageState extends State<LineEditPage> {
  late final _german = TextEditingController(text: widget.line?.german ?? '')
    ..addListener(() => setState(() {}));
  late final _meaning = TextEditingController(text: widget.line?.meaning ?? '');

  @override
  void dispose() {
    _german.dispose();
    _meaning.dispose();
    super.dispose();
  }

  bool get _dirty =>
      _german.text != (widget.line?.german ?? '') ||
      _meaning.text != (widget.line?.meaning ?? '');

  void _save() {
    final state = AppScope.read(context);
    final german = oneLine(_german.text);
    final meaning = oneLine(_meaning.text);
    final old = widget.line;
    state.update(
      old == null
          ? state.book.addLine(widget.situation.id, german, meaning)
          : state.book.editLine(old.id, german, meaning),
    );
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    final l = context.l;
    final ok = await confirmDelete(
      context,
      message: l.deleteLineConfirm,
      action: l.deleteLine,
    );
    if (!ok || !mounted) return;
    final state = AppScope.read(context);
    state.update(state.book.removeLine(widget.line!.id));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => cancelEditor(context, dirty: _dirty),
          child: Text(l.cancel),
        ),
        middle: Text(widget.line == null ? l.newLine : l.editLine),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _german.text.trim().isEmpty ? null : _save,
          child: Text(
            l.save,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: Text(l.germanLabel),
              children: [
                Semantics(
                  label: l.germanLabel,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _german,
                    placeholder: l.germanHint,
                    autofocus: widget.line == null,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 2,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text(l.meaningLabel),
              footer: FooterText(l.lineEditorFooter),
              children: [
                Semantics(
                  label: l.meaningLabel,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _meaning,
                    placeholder: l.meaningHint,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            if (widget.line != null)
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    padding: tilePadding,
                    title: RowText(
                      l.deleteLine,
                      color: CupertinoColors.destructiveRed,
                    ),
                    onTap: _delete,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

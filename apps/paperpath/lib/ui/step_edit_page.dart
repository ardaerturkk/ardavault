import 'package:flutter/cupertino.dart';

import '../model/plan.dart';
import '../state/app_state.dart';
import 'document_edit_page.dart';
import 'names.dart';
import 'widgets.dart';

/// Opens the step editor as a full-screen sheet. With no [step], it adds one.
Future<void> openStepEditor(BuildContext context, {PathStep? step}) =>
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => StepEditPage(step: step),
      ),
    );

class StepEditPage extends StatefulWidget {
  const StepEditPage({super.key, this.step});
  final PathStep? step;

  @override
  State<StepEditPage> createState() => _StepEditPageState();
}

class _StepEditPageState extends State<StepEditPage> {
  late final TextEditingController _title;
  late final TextEditingController _note;
  late List<String> _needs;
  late List<String> _produces;
  String _startTitle = '';
  String _startNote = '';
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final s = widget.step;
    final l = context.l;
    _startTitle = s == null ? '' : stepTitle(l, s);
    _startNote = s == null ? '' : stepNote(l, s);
    _title = TextEditingController(text: _startTitle)
      ..addListener(() => setState(() {}));
    _note = TextEditingController(text: _startNote);
    _needs = [...?s?.needs];
    _produces = [...?s?.produces];
  }

  bool get _dirty {
    final s = widget.step;
    return _title.text != _startTitle ||
        _note.text != _startNote ||
        !_sameList(_needs, s?.needs ?? const []) ||
        !_sameList(_produces, s?.produces ?? const []);
  }

  static bool _sameList(List<String> a, List<String> b) =>
      a.length == b.length && a.toSet().containsAll(b);

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final plan = AppScope.of(context).plan;
    final canSave = _title.text.trim().isNotEmpty;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => cancelEditor(context, dirty: _dirty),
          child: Text(l.cancel),
        ),
        middle: Text(widget.step == null ? l.newStep : l.editStep),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: canSave ? _save : null,
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
              children: [
                Semantics(
                  label: l.title,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _title,
                    textInputAction: TextInputAction.done,
                    placeholder: l.stepTitleHint,
                    autofocus: widget.step == null,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              children: [
                Semantics(
                  label: l.notes,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _note,
                    placeholder: l.notesHint,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 2,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              dividerMargin: 20,
              additionalDividerMargin: 0,
              children: [
                _pickerTile(
                  l.needs,
                  _needs,
                  _produces,
                  plan,
                  (v) => _needs = v,
                ),
                _pickerTile(
                  l.givesYou,
                  _produces,
                  _needs,
                  plan,
                  (v) => _produces = v,
                ),
              ],
            ),
            if (widget.step != null)
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    padding: tilePadding,
                    title: RowText(
                      l.deleteStep,
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

  Widget _pickerTile(
    String label,
    List<String> ids,
    List<String> excluded,
    Plan plan,
    void Function(List<String>) set,
  ) {
    final l = context.l;
    final names = [for (final id in ids) ?plan.doc(id)];
    return CupertinoListTile(
      padding: tilePadding,
      title: RowText(label, maxLines: 2),
      subtitle: names.isEmpty
          ? null
          : Text(
              [for (final d in names) docName(l, d)].join(', '),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
      additionalInfo: Text(names.isEmpty ? l.noneChosen : '${names.length}'),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(
          builder: (_) => DocPickerPage(
            title: label,
            selected: ids,
            excluded: excluded,
            onChanged: (v) => setState(() => set(v)),
          ),
        ),
      ),
    );
  }

  void _save() {
    final state = AppScope.read(context);
    final title = oneLine(_title.text);
    final note = _note.text.trim();
    final old = widget.step;
    if (old == null) {
      state.update(
        state.plan.addStep(
          (id) => PathStep(
            id: id,
            title: title,
            note: note,
            needs: _needs,
            produces: _produces,
          ),
        ),
      );
    } else {
      // Keep starter text localized unless the user actually changed it.
      final keepTitle = old.templateKey != null && title == _startTitle;
      final keepNote = old.templateKey != null && note == _startNote;
      state.update(
        state.plan.withStep(
          PathStep(
            id: old.id,
            templateKey: old.templateKey,
            title: keepTitle ? old.title : title,
            note: keepNote ? old.note : note,
            needs: _needs,
            produces: _produces,
            dueDaysAfterMoveIn: old.dueDaysAfterMoveIn,
            dueDate: old.dueDate,
            appointment: old.appointment,
            done: old.done,
          ),
        ),
      );
    }
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    final l = context.l;
    final ok = await confirmDelete(
      context,
      message: l.deleteStepConfirm,
      action: l.deleteStep,
    );
    if (!ok || !mounted) return;
    final state = AppScope.read(context);
    state.update(state.plan.removeStep(widget.step!.id));
    Navigator.pop(context);
  }
}

/// Multi-select list of documents with a row to create a new one.
class DocPickerPage extends StatefulWidget {
  const DocPickerPage({
    super.key,
    required this.title,
    required this.selected,
    this.excluded = const [],
    required this.onChanged,
  });

  final String title;
  final List<String> selected;

  /// Documents already in the other list: a step cannot need what it gives.
  final List<String> excluded;
  final ValueChanged<List<String>> onChanged;

  @override
  State<DocPickerPage> createState() => _DocPickerPageState();
}

class _DocPickerPageState extends State<DocPickerPage> {
  late List<String> _selected = [...widget.selected];

  void _toggle(String id) {
    setState(() {
      _selected = _selected.contains(id)
          ? [
              for (final s in _selected)
                if (s != id) s,
            ]
          : [..._selected, id];
    });
    widget.onChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final plan = AppScope.of(context).plan;
    final docs = [
      for (final d in plan.docs)
        if (!widget.excluded.contains(d.id)) d,
    ];
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
      child: SafeArea(
        child: ListView(
          children: [
            if (docs.isNotEmpty)
              CupertinoListSection.insetGrouped(
                children: [
                  for (final d in docs)
                    Semantics(
                      selected: _selected.contains(d.id),
                      button: true,
                      child: CupertinoListTile(
                        padding: tilePadding,
                        title: RowText(docName(l, d)),
                        trailing: _selected.contains(d.id)
                            ? const Icon(
                                CupertinoIcons.checkmark,
                                color: accent,
                              )
                            : null,
                        onTap: () => _toggle(d.id),
                      ),
                    ),
                ],
              ),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  padding: tilePadding,
                  leading: const Icon(CupertinoIcons.add, color: accent),
                  title: RowText(l.newDocument, color: accent),
                  onTap: () async {
                    final id = await openDocumentEditor(context);
                    if (id != null) _toggle(id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

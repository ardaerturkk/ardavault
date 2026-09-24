import 'package:flutter/cupertino.dart';

import '../model/board.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'widgets.dart';

/// Opens the flat editor as a full-screen sheet. With no [flat], it adds one.
Future<void> openFlatEditor(BuildContext context, {Flat? flat}) =>
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => FlatEditPage(flat: flat),
      ),
    );

class FlatEditPage extends StatefulWidget {
  const FlatEditPage({super.key, this.flat});
  final Flat? flat;

  @override
  State<FlatEditPage> createState() => _FlatEditPageState();
}

class _FlatEditPageState extends State<FlatEditPage> {
  late final Map<_Field, TextEditingController> _c;
  late final Map<_Field, String> _start;
  late Source _source;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final f = widget.flat;
    final l = context.l;
    _source = f?.source ?? Source.other;
    _start = {
      _Field.title: f?.title ?? '',
      _Field.link: f?.link ?? '',
      _Field.district: f?.district ?? '',
      _Field.warm: editableCents(l, f?.warmCents),
      _Field.cold: editableCents(l, f?.coldCents),
      _Field.size: editableSize(l, f?.sizeSqm),
      _Field.notes: f?.notes ?? '',
    };
    _c = {
      for (final e in _start.entries)
        e.key: TextEditingController(text: e.value)
          ..addListener(() => setState(() {})),
    };
  }

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  String _text(_Field f) => _c[f]!.text.trim();

  bool get _dirty =>
      _source != (widget.flat?.source ?? Source.other) ||
      _c.entries.any((e) => e.value.text != _start[e.key]);

  bool _invalid(_Field f) {
    final t = _text(f);
    if (t.isEmpty) return false;
    return f == _Field.size ? parseSize(t) == null : parseCents(t) == null;
  }

  bool get _anyInvalid =>
      _invalid(_Field.warm) || _invalid(_Field.cold) || _invalid(_Field.size);

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final canSave = _text(_Field.title).isNotEmpty && !_anyInvalid;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => cancelEditor(context, dirty: _dirty),
          child: Text(l.cancel),
        ),
        middle: Text(widget.flat == null ? l.newFlat : l.editFlat),
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
                    controller: _c[_Field.title],
                    textInputAction: TextInputAction.done,
                    placeholder: l.titleHint,
                    autofocus: widget.flat == null,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text(l.listing),
              children: [
                ValueTile(
                  label: l.source,
                  value: sourceName(l, _source),
                  onTap: _pickSource,
                ),
                _FieldRow(
                  label: l.link,
                  controller: _c[_Field.link]!,
                  placeholder: l.linkHint,
                  keyboard: TextInputType.url,
                ),
                _FieldRow(
                  label: l.district,
                  controller: _c[_Field.district]!,
                  placeholder: l.districtHint,
                  capitalize: true,
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text(l.rent),
              footer: _anyInvalid
                  ? Text(
                      l.invalidAmount,
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(
                            fontSize: 13,
                            color: CupertinoColors.systemRed.resolveFrom(
                              context,
                            ),
                          ),
                    )
                  : FooterText(l.rentFooter),
              children: [
                for (final (field, label) in [
                  (_Field.warm, l.warmRent),
                  (_Field.cold, l.coldRent),
                  (_Field.size, l.sizeSqmLabel),
                ])
                  _FieldRow(
                    label: label,
                    controller: _c[field]!,
                    placeholder: l.optional,
                    keyboard: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    invalid: _invalid(field),
                    numeric: true,
                  ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text(l.notes),
              children: [
                Semantics(
                  label: l.notes,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _c[_Field.notes],
                    placeholder: l.notesHint,
                    textCapitalization: TextCapitalization.sentences,
                    minLines: 2,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            if (widget.flat != null)
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    padding: tilePadding,
                    title: RowText(
                      l.deleteFlat,
                      color: CupertinoColors.destructiveRed.resolveFrom(
                        context,
                      ),
                    ),
                    onTap: _delete,
                  ),
                ],
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> _pickSource() async {
    final l = context.l;
    final picked = await showCupertinoModalPopup<Source>(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(l.source),
        actions: [
          for (final s in Source.values)
            CupertinoActionSheetAction(
              isDefaultAction: s == _source,
              onPressed: () => Navigator.pop(context, s),
              child: Text(sourceName(l, s)),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(l.cancel),
        ),
      ),
    );
    if (picked != null) setState(() => _source = picked);
  }

  void _save() {
    final state = AppScope.read(context);
    final title = oneLine(_text(_Field.title));
    final warm = parseCents(_text(_Field.warm));
    final cold = parseCents(_text(_Field.cold));
    final size = parseSize(_text(_Field.size));
    final old = widget.flat;
    if (old == null) {
      final now = state.now();
      state.update(
        state.board.add(
          (id) => Flat(
            id: id,
            title: title,
            source: _source,
            link: oneLine(_text(_Field.link)),
            warmCents: warm,
            coldCents: cold,
            sizeSqm: size,
            district: oneLine(_text(_Field.district)),
            notes: _text(_Field.notes),
            stageSince: now,
            createdAt: now,
          ),
        ),
      );
    } else {
      final current = state.board.flat(old.id) ?? old;
      state.update(
        state.board.withFlat(
          current.copyWith(
            title: title,
            source: _source,
            link: oneLine(_text(_Field.link)),
            warmCents: warm,
            clearWarm: warm == null,
            coldCents: cold,
            clearCold: cold == null,
            sizeSqm: size,
            clearSize: size == null,
            district: oneLine(_text(_Field.district)),
            notes: _text(_Field.notes),
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
      message: l.deleteFlatConfirm,
      action: l.deleteFlat,
    );
    if (!ok || !mounted) return;
    final state = AppScope.read(context);
    state.update(state.board.remove(widget.flat!.id));
    Navigator.pop(context);
  }
}

enum _Field { title, link, district, warm, cold, size, notes }

/// A labelled one-line field. The label sits left of the field, or above it
/// at large text sizes so neither is squeezed.
class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    required this.controller,
    required this.placeholder,
    this.keyboard,
    this.capitalize = false,
    this.invalid = false,
    this.numeric = false,
  });

  final String label;
  final TextEditingController controller;
  final String placeholder;
  final TextInputType? keyboard;
  final bool capitalize;
  final bool invalid;
  final bool numeric;

  @override
  Widget build(BuildContext context) {
    final large = isLargeText(context);
    final field = CupertinoTextField.borderless(
      controller: controller,
      placeholder: placeholder,
      keyboardType: keyboard,
      textCapitalization: capitalize
          ? TextCapitalization.words
          : TextCapitalization.none,
      autocorrect: keyboard == null,
      textAlign: large ? TextAlign.start : TextAlign.end,
      // Long links and district names wrap instead of scrolling sideways.
      maxLines: numeric ? 1 : null,
      textInputAction: TextInputAction.done,
      padding: EdgeInsets.zero,
      style: TextStyle(
        fontFeatures: numeric ? tabular : null,
        color: invalid
            ? CupertinoColors.systemRed.resolveFrom(context)
            : CupertinoColors.label.resolveFrom(context),
      ),
    );
    final text = RowText(label, maxLines: large ? 3 : 1);
    return Semantics(
      label: label,
      textField: true,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 16, 12),
        child: large
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [text, const SizedBox(height: 6), field],
              )
            : Row(
                children: [
                  text,
                  const SizedBox(width: 16),
                  Expanded(child: field),
                ],
              ),
      ),
    );
  }
}

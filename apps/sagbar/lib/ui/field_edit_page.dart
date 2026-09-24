import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/book.dart';
import '../model/content.dart';
import '../state/app_state.dart';
import 'names.dart';
import 'widgets.dart';

/// Opens the one-field editor as a full-screen sheet.
Future<void> openFieldEditor(
  BuildContext context, {
  required String title,
  required String initial,
  required ValueChanged<String> onSave,
  String placeholder = '',
  String? footer,
  TextInputType keyboardType = TextInputType.text,
  TextCapitalization capitalization = TextCapitalization.words,
}) => Navigator.of(context, rootNavigator: true).push(
  CupertinoPageRoute<void>(
    fullscreenDialog: true,
    builder: (_) => FieldEditPage(
      title: title,
      initial: initial,
      onSave: onSave,
      placeholder: placeholder,
      footer: footer,
      keyboardType: keyboardType,
      capitalization: capitalization,
    ),
  ),
);

/// Edits one of the user's text details (not the birth date).
Future<void> editDetail(BuildContext context, Slot slot) {
  final l = context.l;
  final state = AppScope.read(context);
  return openFieldEditor(
    context,
    title: slotLabel(l, slot),
    initial: state.book.detail(slot) ?? '',
    placeholder: slotHint(l, slot),
    footer: switch (slot) {
      Slot.name => l.footerName,
      Slot.address => l.footerAddress,
      _ => null,
    },
    keyboardType: switch (slot) {
      Slot.phone => TextInputType.phone,
      Slot.email => TextInputType.emailAddress,
      _ => TextInputType.text,
    },
    capitalization: switch (slot) {
      Slot.email ||
      Slot.insuranceNumber ||
      Slot.phone => TextCapitalization.none,
      _ => TextCapitalization.words,
    },
    onSave: (v) => state.update(state.book.withDetail(slot, v)),
  );
}

/// Edits the reference number of one situation's visit.
Future<void> editRef(BuildContext context, Situation s) {
  final l = context.l;
  final state = AppScope.read(context);
  return openFieldEditor(
    context,
    title: s.refLabel!,
    initial: state.book.visit(s.id).ref,
    footer: l.refFooter,
    capitalization: TextCapitalization.characters,
    onSave: (v) {
      final book = state.book;
      state.update(
        book.withVisit(s.id, book.visit(s.id).copyWith(ref: oneLine(v))),
      );
    },
  );
}

/// Picks or removes the birth date.
Future<void> editBirthDate(BuildContext context) async {
  final l = context.l;
  final state = AppScope.read(context);
  final current = state.book.birthDate;
  final pick = await pickDate(
    context,
    title: l.fieldBirthDate,
    initial: current ?? DateTime(2000),
    removeLabel: current == null ? null : l.removeBirthDate,
  );
  if (pick == null) return;
  state.update(
    pick.removed
        ? state.book.copyWith(clearBirthDate: true)
        : state.book.copyWith(birthDate: dateOnly(pick.date!)),
  );
}

/// Picks or removes the appointment of one situation's visit.
Future<void> editAppointment(BuildContext context, Situation s) async {
  final l = context.l;
  final state = AppScope.read(context);
  final visit = state.book.visit(s.id);
  final now = state.now();
  final pick = await pickDate(
    context,
    title: l.appointment,
    withTime: true,
    initial: visit.appointment ?? DateTime(now.year, now.month, now.day + 1, 9),
    removeLabel: visit.appointment == null ? null : l.removeAppointment,
  );
  if (pick == null) return;
  final v = state.book.visit(s.id);
  state.update(
    state.book.withVisit(
      s.id,
      pick.removed
          ? v.copyWith(clearAppointment: true)
          : v.copyWith(appointment: pick.date),
    ),
  );
}

class FieldEditPage extends StatefulWidget {
  const FieldEditPage({
    super.key,
    required this.title,
    required this.initial,
    required this.onSave,
    this.placeholder = '',
    this.footer,
    this.keyboardType = TextInputType.text,
    this.capitalization = TextCapitalization.words,
  });

  final String title;
  final String initial;
  final ValueChanged<String> onSave;
  final String placeholder;
  final String? footer;
  final TextInputType keyboardType;
  final TextCapitalization capitalization;

  @override
  State<FieldEditPage> createState() => _FieldEditPageState();
}

class _FieldEditPageState extends State<FieldEditPage> {
  late final _text = TextEditingController(text: widget.initial)
    ..addListener(() => setState(() {}));

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _save() {
    widget.onSave(oneLine(_text.text));
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
          onPressed: () =>
              cancelEditor(context, dirty: _text.text != widget.initial),
          child: Text(l.cancel),
        ),
        middle: Text(widget.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _save,
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
              footer: widget.footer == null ? null : FooterText(widget.footer!),
              children: [
                Semantics(
                  label: widget.title,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _text,
                    placeholder: widget.placeholder,
                    autofocus: true,
                    keyboardType: widget.keyboardType,
                    textCapitalization: widget.capitalization,
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _save(),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('\n')),
                    ],
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../model/book.dart';
import '../model/day.dart';
import '../model/quota.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'job_edit_page.dart';
import 'widgets.dart';

/// Opens the shift editor as a full-screen sheet. With no [shift], it logs a
/// new one.
Future<void> openShiftEditor(BuildContext context, {Shift? shift}) =>
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => ShiftEditPage(shift: shift),
      ),
    );

class ShiftEditPage extends StatefulWidget {
  const ShiftEditPage({super.key, this.shift});
  final Shift? shift;

  @override
  State<ShiftEditPage> createState() => _ShiftEditPageState();
}

class _ShiftEditPageState extends State<ShiftEditPage> {
  late Day _date;
  String? _jobId;
  late int _minutes;
  final _note = TextEditingController();
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final state = AppScope.read(context);
    final s = widget.shift;
    _date = s?.date ?? state.today;
    _jobId = s?.jobId ?? state.book.defaultJob?.id;
    _minutes = s?.minutes ?? _lastMinutesFor(state.book, _jobId);
    _note.text = s?.note ?? '';
    _start = (_date, _jobId, _minutes, _note.text);
  }

  late (Day, String?, int, String) _start;

  /// A new shift starts with the length of the last one in the same job.
  static int _lastMinutesFor(Book book, String? jobId) {
    for (final s in book.shifts.reversed) {
      if (s.jobId == jobId) return s.minutes - s.minutes % 5;
    }
    return 4 * 60;
  }

  bool get _dirty => _start != (_date, _jobId, _minutes, _note.text);

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final book = AppScope.of(context).book;
    final job = book.job(_jobId);
    final canSave = job != null && _minutes > 0;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => cancelEditor(context, dirty: _dirty),
          child: Text(l.cancel),
        ),
        middle: Text(widget.shift == null ? l.newShift : l.editShift),
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
                ValueTile(
                  leading: Icon(
                    CupertinoIcons.calendar,
                    color: accent.resolveFrom(context),
                  ),
                  label: l.date,
                  value: longDate(l, _date),
                  onTap: _pickDate,
                ),
                if (job == null)
                  CupertinoListTile(
                    padding: tilePadding,
                    leading: Icon(
                      CupertinoIcons.add,
                      color: accent.resolveFrom(context),
                    ),
                    title: RowText(
                      l.addAJob,
                      color: accent.resolveFrom(context),
                    ),
                    onTap: _pickJob,
                  )
                else
                  ValueTile(
                    leading: Icon(
                      CupertinoIcons.briefcase,
                      color: accent.resolveFrom(context),
                    ),
                    label: l.job,
                    value: job.name,
                    onTap: _pickJob,
                  ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text(l.hours),
              children: [
                SizedBox(
                  height: 180,
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hm,
                    minuteInterval: 5,
                    initialTimerDuration: Duration(minutes: _minutes),
                    onTimerDurationChanged: (d) =>
                        setState(() => _minutes = d.inMinutes),
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              footer: FooterText(
                l.halfDayRule(hoursText(l, book.settings.halfDayMaxMinutes)),
              ),
              children: [_resultTile(book, job)],
            ),
            CupertinoListSection.insetGrouped(
              children: [
                Semantics(
                  label: l.note,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _note,
                    placeholder: l.noteHint,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                  ),
                ),
              ],
            ),
            if (widget.shift != null)
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    padding: tilePadding,
                    title: RowText(
                      l.deleteShift,
                      color: CupertinoColors.destructiveRed,
                    ),
                    onTap: _delete,
                  ),
                ],
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// How the day counts with this shift, live.
  Widget _resultTile(Book book, Job? job) {
    final l = context.l;
    var others = 0;
    var otherCount = 0;
    for (final s in book.shifts) {
      if (s.date != _date || s.id == widget.shift?.id) continue;
      if (!book.counts(s)) continue;
      others += s.minutes;
      otherCount++;
    }
    final counts = job?.kind.counts ?? true;
    final total = others + (counts ? _minutes : 0);
    final status = statusForMinutes(
      counts ? total : 0,
      book.settings.halfDayMaxMinutes,
    );
    final String title;
    if (!counts) {
      title = l.countsNotUniversity;
    } else if (_minutes == 0) {
      title = l.countsZero;
    } else {
      title = status == DayStatus.full ? l.countsFull : l.countsHalf;
    }
    return CupertinoListTile(
      padding: tilePadding,
      leading: dayStatusIcon(
        context,
        _minutes == 0 ? DayStatus.notCounted : status,
      ),
      title: RowText(title),
      subtitle: counts && otherCount > 0 && _minutes > 0
          ? Text(
              l.withOtherShifts(otherCount, hoursText(l, total)),
              maxLines: 4,
            )
          : null,
    );
  }

  Future<void> _pickDate() async {
    final l = context.l;
    final pick = await pickDate(
      context,
      title: l.date,
      initial: _date.toLocal(),
    );
    if (pick?.date == null) return;
    setState(() => _date = Day.of(pick!.date!));
  }

  Future<void> _pickJob() async {
    final book = AppScope.read(context).book;
    final String? id;
    if (book.jobs.isEmpty) {
      id = await openJobEditor(context);
    } else {
      id = await pickJob(context, selected: _jobId);
    }
    if (id != null && mounted) setState(() => _jobId = id);
  }

  void _save() {
    final state = AppScope.read(context);
    final old = widget.shift;
    Shift make(String id) => Shift(
      id: id,
      jobId: _jobId!,
      date: _date,
      minutes: _minutes,
      note: _note.text.trim(),
    );
    if (old == null) {
      state.update(state.book.addShift(make).$1);
    } else {
      state.update(state.book.withShift(make(old.id)));
    }
    unawaited(HapticFeedback.lightImpact());
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    final l = context.l;
    final ok = await confirmDelete(
      context,
      message: l.deleteShiftConfirm,
      action: l.deleteShift,
    );
    if (!ok || !mounted) return;
    final state = AppScope.read(context);
    state.update(state.book.removeShift(widget.shift!.id));
    Navigator.pop(context);
  }
}

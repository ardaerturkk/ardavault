import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../model/book.dart';
import '../state/app_state.dart';
import 'format.dart';
import 'widgets.dart';

/// Opens the job editor as a full-screen sheet. Returns the job's id after
/// Save, or null.
Future<String?> openJobEditor(BuildContext context, {Job? job}) =>
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<String>(
        fullscreenDialog: true,
        builder: (_) => JobEditPage(job: job),
      ),
    );

/// Pushes a list of jobs; returns the chosen job's id, or null.
Future<String?> pickJob(BuildContext context, {String? selected}) =>
    Navigator.of(context).push(
      CupertinoPageRoute<String>(
        builder: (_) => JobPickerPage(selected: selected),
      ),
    );

class JobEditPage extends StatefulWidget {
  const JobEditPage({super.key, this.job});
  final Job? job;

  @override
  State<JobEditPage> createState() => _JobEditPageState();
}

class _JobEditPageState extends State<JobEditPage> {
  late final TextEditingController _name;
  late final TextEditingController _rate;
  late JobKind _kind;
  late final (String, JobKind, String) _start;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final j = widget.job;
    final l = context.l;
    _name = TextEditingController(text: j?.name ?? '')
      ..addListener(() => setState(() {}));
    _rate = TextEditingController(
      text: j?.rateCents == null
          ? ''
          : NumberFormat('0.00', l.localeName).format(j!.rateCents! / 100),
    )..addListener(() => setState(() {}));
    _kind = j?.kind ?? JobKind.regular;
    _start = (_name.text, _kind, _rate.text);
  }

  bool get _dirty => _start != (_name.text, _kind, _rate.text);

  /// Null when the field is empty; -1 when it is not a valid amount.
  int? get _rateCents {
    if (_rate.text.trim().isEmpty) return null;
    final v = parseDecimal(_rate.text);
    if (v == null || v < 0 || v > 10000) return -1;
    return (v * 100).round();
  }

  @override
  void dispose() {
    _name.dispose();
    _rate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final canSave = _name.text.trim().isNotEmpty && _rateCents != -1;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => cancelEditor(context, dirty: _dirty),
          child: Text(l.cancel),
        ),
        middle: Text(widget.job == null ? l.newJob : l.editJob),
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
                  label: l.jobNameHint,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _name,
                    placeholder: l.jobNameHint,
                    autofocus: widget.job == null,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text(l.jobType),
              children: [
                for (final k in JobKind.values)
                  Semantics(
                    selected: _kind == k,
                    button: true,
                    child: CupertinoListTile(
                      padding: tilePadding,
                      title: RowText(jobKindLabel(l, k)),
                      subtitle: Text(jobKindInfo(l, k), maxLines: 4),
                      trailing: _kind == k
                          ? Icon(
                              CupertinoIcons.checkmark,
                              color: accent.resolveFrom(context),
                            )
                          : null,
                      onTap: () => setState(() => _kind = k),
                    ),
                  ),
              ],
            ),
            if (_kind == JobKind.minijob)
              CupertinoListSection.insetGrouped(
                header: Text(l.hourlyPay),
                footer: FooterText(l.hourlyPayFooter),
                children: [
                  Semantics(
                    label: l.hourlyPay,
                    child: CupertinoTextFormFieldRow(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        14,
                        8,
                        14,
                        8,
                      ),
                      controller: _rate,
                      placeholder: l.hourlyPayHint,
                      prefix: Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8),
                        child: Text(
                          '€',
                          style: TextStyle(
                            color: CupertinoColors.secondaryLabel.resolveFrom(
                              context,
                            ),
                          ),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.job != null)
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    padding: tilePadding,
                    title: RowText(
                      l.deleteJob,
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

  void _save() {
    final state = AppScope.read(context);
    final old = widget.job;
    final rate = _rateCents;
    Job make(String id) => Job(
      id: id,
      name: oneLine(_name.text),
      kind: _kind,
      rateCents: rate ?? (_kind == JobKind.minijob ? null : old?.rateCents),
    );
    final String id;
    if (old == null) {
      final (book, newId) = state.book.addJob(make);
      state.update(book);
      id = newId;
    } else {
      state.update(state.book.withJob(make(old.id)));
      id = old.id;
    }
    Navigator.pop(context, id);
  }

  Future<void> _delete() async {
    final l = context.l;
    final state = AppScope.read(context);
    final count = state.book.shiftCountFor(widget.job!.id);
    final ok = await confirmDelete(
      context,
      message: count == 0 ? l.deleteJobConfirm : l.deleteJobWithShifts(count),
      action: l.deleteJob,
    );
    if (!ok || !mounted) return;
    state.update(state.book.removeJob(widget.job!.id));
    Navigator.pop(context);
  }
}

/// Single choice of job, with a row to create a new one.
class JobPickerPage extends StatelessWidget {
  const JobPickerPage({super.key, this.selected});
  final String? selected;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final book = AppScope.of(context).book;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(middle: Text(l.job)),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              children: [
                for (final j in book.jobs)
                  Semantics(
                    selected: j.id == selected,
                    button: true,
                    child: CupertinoListTile(
                      padding: tilePadding,
                      title: RowText(j.name),
                      subtitle: Text(jobKindLabel(l, j.kind)),
                      trailing: j.id == selected
                          ? Icon(
                              CupertinoIcons.checkmark,
                              color: accent.resolveFrom(context),
                            )
                          : null,
                      onTap: () => Navigator.pop(context, j.id),
                    ),
                  ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  padding: tilePadding,
                  leading: Icon(
                    CupertinoIcons.add,
                    color: accent.resolveFrom(context),
                  ),
                  title: RowText(l.newJob, color: accent.resolveFrom(context)),
                  onTap: () async {
                    final id = await openJobEditor(context);
                    if (id != null && context.mounted) {
                      Navigator.pop(context, id);
                    }
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

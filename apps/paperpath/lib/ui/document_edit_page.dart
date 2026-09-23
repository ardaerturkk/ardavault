import 'package:flutter/cupertino.dart';

import '../model/plan.dart';
import '../state/app_state.dart';
import 'names.dart';
import 'widgets.dart';

/// Opens the document editor as a full-screen sheet. Returns the id of a
/// newly added document, or null.
Future<String?> openDocumentEditor(BuildContext context, {Doc? doc}) =>
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<String>(
        fullscreenDialog: true,
        builder: (_) => DocumentEditPage(doc: doc),
      ),
    );

class DocumentEditPage extends StatefulWidget {
  const DocumentEditPage({super.key, this.doc});
  final Doc? doc;

  @override
  State<DocumentEditPage> createState() => _DocumentEditPageState();
}

class _DocumentEditPageState extends State<DocumentEditPage> {
  late final TextEditingController _name;
  late final TextEditingController _note;
  String _startName = '';
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;
    final d = widget.doc;
    _startName = d == null ? '' : docName(context.l, d);
    _name = TextEditingController(text: _startName)
      ..addListener(() => setState(() {}));
    _note = TextEditingController(text: d?.note ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Text(l.cancel),
        ),
        middle: Text(widget.doc == null ? l.newDocument : l.editDocument),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _name.text.trim().isEmpty ? null : _save,
          child: Text(
            l.save,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoFormSection.insetGrouped(
              header: Text(l.name),
              children: [
                CupertinoTextFormFieldRow(
                  controller: _name,
                  placeholder: l.docNameHint,
                  autofocus: widget.doc == null,
                  textCapitalization: TextCapitalization.words,
                  maxLines: null,
                ),
              ],
            ),
            CupertinoFormSection.insetGrouped(
              header: Text(l.notes),
              children: [
                CupertinoTextFormFieldRow(
                  controller: _note,
                  placeholder: l.notesHint,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 2,
                  maxLines: null,
                ),
              ],
            ),
            if (widget.doc != null)
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    title: RowText(
                      l.deleteDocument,
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

  void _save() {
    final state = AppScope.read(context);
    final name = _name.text.trim();
    final note = _note.text.trim();
    final old = widget.doc;
    if (old == null) {
      final next = state.plan.addDoc(
        (id) => Doc(id: id, name: name, note: note),
      );
      state.update(next);
      Navigator.pop(context, next.docs.last.id);
      return;
    }
    final keepName = old.templateKey != null && name == _startName;
    state.update(
      state.plan.withDoc(
        Doc(
          id: old.id,
          templateKey: old.templateKey,
          name: keepName ? old.name : name,
          note: note,
          have: old.have,
        ),
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    final l = context.l;
    final ok = await confirmDelete(
      context,
      message: l.deleteDocConfirm,
      action: l.deleteDocument,
    );
    if (!ok || !mounted) return;
    final state = AppScope.read(context);
    state.update(state.plan.removeDoc(widget.doc!.id));
    Navigator.pop(context);
  }
}

import 'package:flutter/cupertino.dart';

import 'format.dart';
import 'widgets.dart';

/// Edits one limit. Save is enabled only for a number above zero and at
/// most [max].
class NumberEditPage extends StatefulWidget {
  const NumberEditPage({
    super.key,
    required this.title,
    required this.initial,
    required this.max,
    required this.help,
    required this.onSave,
    this.decimals = false,
    this.unit,
  });

  final String title;
  final double initial;
  final double max;
  final String help;
  final bool decimals;
  final String? unit;
  final ValueChanged<double> onSave;

  @override
  State<NumberEditPage> createState() => _NumberEditPageState();
}

class _NumberEditPageState extends State<NumberEditPage> {
  TextEditingController? _text;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _text ??= TextEditingController(
      text: numberText(
        context.l,
        widget.initial,
      ).replaceAll(RegExp(r'[\s.,](?=\d{3}\b)'), ''),
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _text?.dispose();
    super.dispose();
  }

  double? get _value {
    final v = parseDecimal(_text!.text);
    if (v == null || v <= 0 || v > widget.max) return null;
    if (!widget.decimals && v != v.roundToDouble()) return null;
    return v;
  }

  void _save() {
    final v = _value;
    if (v == null) return;
    widget.onSave(v);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final valid = _value != null;
    final showError = !valid && _text!.text.trim().isNotEmpty;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: valid ? _save : null,
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
              footer: FooterText(showError ? l.valueInvalid : widget.help),
              children: [
                Semantics(
                  label: widget.title,
                  child: CupertinoTextFormFieldRow(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 8, 14, 8),
                    controller: _text,
                    autofocus: true,
                    style: const TextStyle(fontFeatures: tabular),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: widget.decimals,
                    ),
                    onFieldSubmitted: (_) => _save(),
                    prefix: widget.unit == null
                        ? null
                        : Padding(
                            padding: const EdgeInsetsDirectional.only(end: 8),
                            child: Text(
                              widget.unit!,
                              style: TextStyle(
                                color: CupertinoColors.secondaryLabel
                                    .resolveFrom(context),
                              ),
                            ),
                          ),
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

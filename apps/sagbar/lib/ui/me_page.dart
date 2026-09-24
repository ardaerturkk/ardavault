import 'package:flutter/cupertino.dart';

import '../model/content.dart';
import '../state/app_state.dart';
import 'field_edit_page.dart';
import 'names.dart';
import 'widgets.dart';

IconData slotIcon(Slot slot) => switch (slot) {
  Slot.name || Slot.nameSpelled => CupertinoIcons.person,
  Slot.birthDate => CupertinoIcons.calendar,
  Slot.address => CupertinoIcons.house,
  Slot.phone => CupertinoIcons.phone,
  Slot.email => CupertinoIcons.envelope,
  Slot.insurer => CupertinoIcons.heart,
  Slot.insuranceNumber => CupertinoIcons.creditcard,
  Slot.studentId => CupertinoIcons.book,
  Slot.ref => CupertinoIcons.number,
  Slot.time || Slot.date => CupertinoIcons.clock,
};

/// A row for one personal detail; tapping it opens its editor.
class DetailTile extends StatelessWidget {
  const DetailTile({super.key, required this.slot});
  final Slot slot;

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    final book = AppScope.of(context).book;
    final String? value = slot == Slot.birthDate
        ? (book.birthDate == null ? null : longDate(l, book.birthDate!))
        : book.detail(slot);
    return ValueTile(
      leading: Icon(slotIcon(slot), color: accent.resolveFrom(context)),
      label: slotLabel(l, slot),
      value: value ?? l.notSet,
      valueColor: value == null
          ? CupertinoColors.tertiaryLabel.resolveFrom(context)
          : null,
      onTap: () => slot == Slot.birthDate
          ? editBirthDate(context)
          : editDetail(context, slot),
    );
  }
}

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = context.l;
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text(l.tabMe)),
          const SliverToBoxAdapter(child: ProblemBanner()),
          SliverSafeArea(
            top: false,
            sliver: SliverList.list(
              children: [
                CupertinoListSection.insetGrouped(
                  header: Text(l.aboutYou),
                  children: const [
                    DetailTile(slot: Slot.name),
                    DetailTile(slot: Slot.birthDate),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: Text(l.contact),
                  children: const [
                    DetailTile(slot: Slot.address),
                    DetailTile(slot: Slot.phone),
                    DetailTile(slot: Slot.email),
                  ],
                ),
                CupertinoListSection.insetGrouped(
                  header: Text(l.numbers),
                  footer: FooterText(l.meFooter),
                  children: const [
                    DetailTile(slot: Slot.insurer),
                    DetailTile(slot: Slot.insuranceNumber),
                    DetailTile(slot: Slot.studentId),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SubtopicItemModal {
  int id;
  String name;
  String risks;
  String controls;

  SubtopicItemModal({
    required this.id,
    required this.name,
    required this.risks,
    required this.controls,
  });
}

class SubtopicItem extends StatefulWidget {
  final SubtopicItemModal subtopicItem;
  final Function(SubtopicItemModal) onRemoveSubtopicItem;

  const SubtopicItem({
    super.key,
    required this.subtopicItem,
    required this.onRemoveSubtopicItem,
  });

  @override
  State<SubtopicItem> createState() => _SubtopicItemState();
}

class _SubtopicItemState extends State<SubtopicItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Row(
          children: [
            InkWell(
              onTap: () => widget.onRemoveSubtopicItem(widget.subtopicItem),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey,
                ),
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text('Subtopic ${widget.subtopicItem.id}'),
            Expanded(child: Container(color: Colors.blue))
          ],
        ),
        Row(
          children: [
            const Text("Risks"),
            Expanded(child: TextFormField()),
          ],
        ),
        Row(
          children: [
            const Text("Controls"),
            Expanded(child: TextFormField()),
          ],
        ),
      ]),
    );
  }
}

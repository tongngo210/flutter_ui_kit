import 'package:flutter/material.dart';

import 'expansion_list_subtopics.dart';
import 'subtopic_item.dart';

class TopicItemModal {
  int id;
  String name;
  bool isExpanded;
  List<SubtopicItemModal> subtopics;

  TopicItemModal({
    required this.id,
    required this.name,
    required this.subtopics,
    this.isExpanded = false,
  });
}

class TopicItem extends StatefulWidget {
  final TopicItemModal topicItem;
  final Function(TopicItemModal) onRemoveItem;

  const TopicItem({
    super.key,
    required this.topicItem,
    required this.onRemoveItem,
  });

  @override
  State<TopicItem> createState() => _TopicItemState();
}

class _TopicItemState extends State<TopicItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => widget.onRemoveItem(widget.topicItem),
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
              Text('Topic ${widget.topicItem.id}'),
              Expanded(child: Container(color: Colors.blue))
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: widget.topicItem.isExpanded
                ? ExpansionListSubtopics(
                    listSubtopics: widget.topicItem.subtopics,
                    onChangedListSubtopics: (listSubtopics) {
                      widget.topicItem.subtopics = listSubtopics;
                    },
                  )
                : const SizedBox(),
          ),
          InkWell(
            onTap: () => setState(() {
              widget.topicItem.isExpanded = !widget.topicItem.isExpanded;
            }),
            child: SizedBox(
              height: 30,
              child: Center(
                child: Icon(widget.topicItem.isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              ),
            ),
          )
        ],
      ),
    );
  }
}

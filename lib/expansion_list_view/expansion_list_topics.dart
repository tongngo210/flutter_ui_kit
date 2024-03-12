import 'dart:math';

import 'package:flutter/material.dart';

import 'topic_item.dart';

class ExpansionListTopics extends StatefulWidget {
  final List<TopicItemModal> listTopics;

  const ExpansionListTopics({
    super.key,
    required this.listTopics,
  });

  @override
  State<ExpansionListTopics> createState() => _ExpansionListTopicsState();
}

class _ExpansionListTopicsState extends State<ExpansionListTopics> {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _animatedListKey,
      initialItemCount: widget.listTopics.length + 1,
      itemBuilder: (context, index, animation) {
        if (index == widget.listTopics.length) return _addTopicWidget();
        return Column(
          children: [
            SizeTransition(
              sizeFactor: animation,
              child: TopicItem(
                topicItem: widget.listTopics[index],
                onRemoveItem: (item) => _removeTopic(item),
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  Widget _addTopicWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        onTap: () {
          widget.listTopics.add(TopicItemModal(
            id: Random.secure().nextInt(1230),
            name: "",
            subtopics: [],
          ));
          _animatedListKey.currentState
              ?.insertItem(widget.listTopics.length - 1);
        },
        child: const Row(
          children: [
            Icon(Icons.add_circle),
            SizedBox(width: 12),
            Text("Add Topic"),
          ],
        ),
      ),
    );
  }

  void _removeTopic(TopicItemModal item) {
    final index =
        widget.listTopics.indexWhere((element) => element.id == item.id);
    final removedItem = widget.listTopics.removeAt(index);
    _animatedListKey.currentState?.removeItem(
        index,
        (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: TopicItem(
                topicItem: removedItem,
                onRemoveItem: (_) {},
              ),
            ));
  }
}

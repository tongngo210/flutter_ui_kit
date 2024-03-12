import 'dart:math';

import 'package:flutter/material.dart';

import 'subtopic_item.dart';

class ExpansionListSubtopics extends StatefulWidget {
  final List<SubtopicItemModal> listSubtopics;
  final Function(List<SubtopicItemModal>) onChangedListSubtopics;

  const ExpansionListSubtopics({
    super.key,
    required this.listSubtopics,
    required this.onChangedListSubtopics,
  });

  @override
  State<ExpansionListSubtopics> createState() => _ExpansionListSubtopicsState();
}

class _ExpansionListSubtopicsState extends State<ExpansionListSubtopics> {
  final _animatedListKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: AnimatedList(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          key: _animatedListKey,
          initialItemCount: widget.listSubtopics.length + 1,
          itemBuilder: (context, index, animation) {
            if (index == widget.listSubtopics.length) {
              return _addSubtopicWidget();
            }

            if (index > widget.listSubtopics.length) {
              return const SizedBox();
            }

            return SizeTransition(
              sizeFactor: animation,
              child: SubtopicItem(
                subtopicItem: widget.listSubtopics[index],
                onRemoveSubtopicItem: _removeSubtopic,
              ),
            );
          }),
    );
  }

  Widget _addSubtopicWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.listSubtopics.add(SubtopicItemModal(
              id: Random.secure().nextInt(1230),
              name: "",
              risks: "",
              controls: "",
            ));
            _animatedListKey.currentState
                ?.insertItem(widget.listSubtopics.length - 1);
            widget.onChangedListSubtopics(widget.listSubtopics);
          });
        },
        child: const Row(
          children: [
            Icon(Icons.add_circle),
            SizedBox(width: 12),
            Text("Add Subtopic"),
          ],
        ),
      ),
    );
  }

  void _removeSubtopic(SubtopicItemModal item) {
    final index =
        widget.listSubtopics.indexWhere((element) => element.id == item.id);
    final removedItem = widget.listSubtopics.removeAt(index);
    _animatedListKey.currentState?.removeItem(
        index,
        (context, animation) => SizeTransition(
              sizeFactor: animation,
              child: SubtopicItem(
                subtopicItem: removedItem,
                onRemoveSubtopicItem: (_) {},
              ),
            ));
  }
}

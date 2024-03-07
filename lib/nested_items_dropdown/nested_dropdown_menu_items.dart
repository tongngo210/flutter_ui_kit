import 'package:flutter/material.dart';

import 'nested_dropdown_menu_item.dart';
export 'nested_dropdown_menu_item.dart';

class NestedDropdownMenuItems extends StatefulWidget {
  final List<NestedDropdownMenuItem> listItems;
  final NestedDropdownMenuItem? selectedItem;
  final Function(NestedDropdownMenuItem) onTapItem;
  final double dropdownMenuHeight;
  final double stepLeftPadding;
  final TextStyle? itemTextStyle;

  const NestedDropdownMenuItems({
    super.key,
    required this.listItems,
    required this.onTapItem,
    this.selectedItem,
    this.dropdownMenuHeight = 200,
    this.stepLeftPadding = 10,
    this.itemTextStyle = const TextStyle(fontSize: 15, color: Colors.black),
  });

  @override
  State<NestedDropdownMenuItems> createState() =>
      _NestedDropdownMenuItemsState();
}

class _NestedDropdownMenuItemsState extends State<NestedDropdownMenuItems> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: SizedBox(
        height: widget.dropdownMenuHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _contentDropdown(widget.listItems, 0),
          ),
        ),
      ),
    );
  }

  List<Widget> _contentDropdown(
    List<NestedDropdownMenuItem> listItems,
    int level,
  ) {
    return listItems
        .map((item) => Container(
              color: (item.id == widget.selectedItem?.id) ? Colors.amber : null,
              padding: EdgeInsets.only(left: level * widget.stepLeftPadding),
              child: item.children.isNotEmpty
                  ? ExpansionTile(
                      tilePadding: EdgeInsets.zero,
                      title: Text(item.name, style: widget.itemTextStyle),
                      collapsedIconColor: Colors.black,
                      iconColor: Colors.black,
                      children: item.children.isEmpty
                          ? _contentDropdown(item.children, 0)
                          : _contentDropdown(item.children, level + 1),
                    )
                  : ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(item.name, style: widget.itemTextStyle),
                      onTap: () => widget.onTapItem(item),
                    ),
            ))
        .toList();
  }
}

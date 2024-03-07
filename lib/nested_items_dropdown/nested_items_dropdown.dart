import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'nested_dropdown_menu_items.dart';
export 'nested_dropdown_menu_items.dart';

class NestedItemsDropdown extends StatefulWidget {
  final List<NestedDropdownMenuItem> items;
  final String? hint;
  final double buttonHeight;
  final double dropdownMenuHeight;
  final TextStyle? hintTextStyle;
  final TextStyle? itemTextStyle;
  final EdgeInsets? dropdownMenuPadding;

  const NestedItemsDropdown({
    super.key,
    required this.items,
    this.hint,
    this.buttonHeight = 60,
    this.dropdownMenuHeight = 200,
    this.hintTextStyle = const TextStyle(fontSize: 14, color: Colors.black),
    this.itemTextStyle,
    this.dropdownMenuPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
  });

  @override
  State<NestedItemsDropdown> createState() => _NestedItemsDropdownState();
}

class _NestedItemsDropdownState extends State<NestedItemsDropdown>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> animation;

  bool _isDropdownOpen = false;

  NestedDropdownMenuItem? selectedItem;
  String? shownValue;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 0.5).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint:
            Text(shownValue ?? widget.hint ?? '', style: widget.hintTextStyle),
        items: [
          DropdownMenuItem<String>(
            value: '',
            child: NestedDropdownMenuItems(
              listItems: widget.items,
              selectedItem: selectedItem,
              onTapItem: (value) {
                setState(() {
                  selectedItem = value;
                  shownValue = value.name;
                  Navigator.of(context).pop();
                });
              },
            ),
          )
        ],
        onChanged: (_) {},
        dropdownStyleData: DropdownStyleData(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          offset: const Offset(0, -1),
          padding: EdgeInsets.zero,
          scrollPadding: widget.dropdownMenuPadding,
        ),
        buttonStyleData: ButtonStyleData(height: widget.buttonHeight),
        menuItemStyleData: MenuItemStyleData(
          height: widget.dropdownMenuHeight,
          padding: EdgeInsets.zero,
        ),
        iconStyleData: IconStyleData(
          icon: RotationTransition(
            turns: animation,
            child: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          ),
        ),
        onMenuStateChange: (isExpanded) {
          setState(() {
            _isDropdownOpen = isExpanded;
            _isDropdownOpen
                ? _animationController.forward()
                : _animationController.reverse();
          });
        },
      ),
    );
  }
}

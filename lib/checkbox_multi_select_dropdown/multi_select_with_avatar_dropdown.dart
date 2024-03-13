import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class UserWithAvatar {
  String name;
  String imageURL;

  UserWithAvatar({
    required this.name,
    required this.imageURL,
  });
}

class MultiSelectWithAvatarDropdown extends StatefulWidget {
  final List<ValueItem<UserWithAvatar>> listOptions;
  final List<ValueItem<UserWithAvatar>> listDisableOptions;
  final Function(List<ValueItem<UserWithAvatar>>)? onOptionSelected;
  final Function(int, ValueItem<UserWithAvatar>)? onOptionRemoved;

  const MultiSelectWithAvatarDropdown({
    super.key,
    required this.listOptions,
    this.listDisableOptions = const [],
    this.onOptionSelected,
    this.onOptionRemoved,
  });

  @override
  State<MultiSelectWithAvatarDropdown> createState() =>
      _MultiSelectWithAvatarDropdownState();
}

class _MultiSelectWithAvatarDropdownState
    extends State<MultiSelectWithAvatarDropdown> {
  final MultiSelectController<UserWithAvatar> _controller =
      MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      controller: _controller,
      selectionType: SelectionType.multi,
      onOptionSelected: widget.onOptionSelected,
      onOptionRemoved: widget.onOptionRemoved,
      options: widget.listOptions,
      disabledOptions: widget.listDisableOptions,
      optionsBackgroundColor: Colors.transparent,
      chipConfig: const ChipConfig(
        wrapType: WrapType.wrap,
        runSpacing: 0,
      ),
      optionBuilder: (context, option, isSelected) {
        return ListTile(
          title: Text(option.label, style: const TextStyle(fontSize: 14)),
          selectedColor: Theme.of(context).primaryColor,
          selected: isSelected,
          autofocus: true,
          dense: true,
          tileColor: Colors.transparent,
          selectedTileColor: Colors.grey.shade200,
          enabled: !widget.listDisableOptions.contains(option),
          leading: CircleAvatar(
              foregroundImage: NetworkImage(option.value?.imageURL ?? '')),
          trailing: Icon(isSelected
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank_outlined),
        );
      },
    );
  }
}

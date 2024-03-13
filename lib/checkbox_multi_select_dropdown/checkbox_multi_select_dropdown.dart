import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class CheckboxMultiSelectDropdown extends StatefulWidget {
  final List<ValueItem<String>> listOptions;
  final List<ValueItem<String>> listDisableOptions;
  final Function(List<ValueItem<String>>)? onOptionSelected;
  final Function(int, ValueItem<String>)? onOptionRemoved;

  const CheckboxMultiSelectDropdown({
    super.key,
    required this.listOptions,
    this.listDisableOptions = const [],
    this.onOptionSelected,
    this.onOptionRemoved,
  });

  @override
  State<CheckboxMultiSelectDropdown> createState() =>
      _CheckboxMultiSelectDropdownState();
}

class _CheckboxMultiSelectDropdownState
    extends State<CheckboxMultiSelectDropdown> {
  final MultiSelectController<String> _controller = MultiSelectController();

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
          leading: Icon(isSelected
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank_outlined),
        );
      },
    );
  }
}

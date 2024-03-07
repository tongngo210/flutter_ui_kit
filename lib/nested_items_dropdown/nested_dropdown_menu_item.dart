class NestedDropdownMenuItem {
  int id;
  String name;
  List<NestedDropdownMenuItem> children;

  NestedDropdownMenuItem({
    required this.id,
    required this.name,
    required this.children,
  });
}

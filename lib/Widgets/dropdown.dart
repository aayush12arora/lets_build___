import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/cupertino.dart';
class Dropdown extends StatefulWidget {
  const Dropdown({Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  List dropdownItemList = [
    {'label': 'Customer', 'value': 'Customer'}, // label is required and unique
    {'label': 'Exporter', 'value': 'Exporter'},
    {'label': 'Re-Exporter', 'value': 'Re-Exporter'},

  ];
  Widget build(BuildContext context) {
    return CoolDropdown(
      dropdownList: dropdownItemList,
      onChange: (_) {},
      defaultValue: dropdownItemList[3],
      // placeholder: 'insert...',
    ) ;






  }
}

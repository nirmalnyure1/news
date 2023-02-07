import 'package:flutter/material.dart';

class CommonDropDownWidget extends StatelessWidget {
  final List<String> dropDownItem;
  final String hintText;
  final String? selectedValue;
  final Function(String value) onChange;
  const CommonDropDownWidget(
      {super.key,
      required this.dropDownItem,
      required this.onChange,
      this.selectedValue,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      underline: const SizedBox(),
      hint: Text(hintText),
      items: dropDownItem.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: (String? value) {
        onChange(value ?? "");
      },
    );
  }
}
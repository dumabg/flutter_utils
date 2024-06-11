import 'package:dart_utils/extensions/list_map_with_index.dart';
import 'package:flutter/material.dart';

class CheckboxList extends StatefulWidget {
  final List<String> options;
  final List<bool?> checked;
  final bool checkOnLeft;

  CheckboxList(
      {required this.options,
      required this.checked,
      super.key,
      this.checkOnLeft = true}) {
    assert(options.length == checked.length);
  }

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options
          .mapWithIndex<CheckboxListTile>(
              (String option, int i) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(option),
                  value: widget.checked[i],
                  onChanged: (bool? value) {
                    setState(() {
                      widget.checked[i] = value ?? false;
                    });
                  }))
          .toList(),
    );
  }
}

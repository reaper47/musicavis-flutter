import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

class DropdownTile<T> extends StatefulWidget {
  final String title;
  final String subtitle;

  final T defaultValue;
  final List<T> values;
  final List<String> displayValues;

  final String boxName;
  final String settingKey;

  final Function onChange;

  DropdownTile(
    this.title, {
    this.subtitle,
    this.defaultValue,
    this.values,
    this.displayValues,
    this.boxName,
    this.settingKey,
    this.onChange,
  });

  _DropdownTileState<T> createState() => _DropdownTileState<T>();
}

class _DropdownTileState<T> extends State<DropdownTile<T>> {
  Box<dynamic> _box;

  @override
  void initState() {
    _box = Hive.box(widget.boxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    T value = _box.get(widget.settingKey, defaultValue: widget.defaultValue);

    return ListTile(
      title: Text(widget.title),
      subtitle: widget.subtitle == null ? null : Text(widget.subtitle),
      trailing: DropdownButton<T>(
        items: widget.values
            .map(
              (el) => DropdownMenuItem<T>(
                value: el,
                child: Text(
                  widget.displayValues?.elementAt(widget.values.indexOf(el)) ??
                      el.toString(),
                  textAlign: TextAlign.end,
                ),
              ),
            )
            .toList(),
        onChanged: (value) => onChange(value),
        value: value,
      ),
    );
  }

  onChange(T value) {
    _box.put(widget.settingKey, value);
    if (widget.onChange != null) {
      widget.onChange(value);
    }
  }
}

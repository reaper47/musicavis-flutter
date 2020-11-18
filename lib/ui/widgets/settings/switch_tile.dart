import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

class SwitchTile extends StatefulWidget {
  final String title;
  final String subtitle;

  final bool defaultValue;

  final String boxName;
  final String settingKey;

  final Color activeColor;

  SwitchTile(
    this.title, {
    this.subtitle,
    this.defaultValue = false,
    this.boxName,
    this.settingKey,
    this.activeColor,
  });

  @override
  _SwitchTileState createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
  Box<dynamic> _box;

  @override
  void initState() {
    _box = Hive.box(widget.boxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _isActive = _box.get(
      widget.settingKey,
      defaultValue: widget.defaultValue,
    );

    return ListTile(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      trailing: Switch.adaptive(
        value: _isActive,
        activeColor: widget.activeColor,
        onChanged: (value) => _toggle(value),
      ),
      onTap: () => _toggle(!_isActive),
    );
  }

  _toggle(bool value) async {
    await _box.put(widget.settingKey, value);
    setState(() {});
  }
}

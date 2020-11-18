import 'package:flutter/material.dart';

class DialogLink extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;
  final AlertDialog dialog;
  final bool isBarrierDismissible;

  DialogLink(
    this.title, {
    this.subtitle,
    this.leading,
    this.trailing,
    this.dialog,
    this.isBarrierDismissible,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      leading: leading,
      trailing: trailing,
      onTap: () async => await showDialog(
        context: context,
        builder: (context) => dialog,
        barrierDismissible: isBarrierDismissible,
      ),
    );
  }
}

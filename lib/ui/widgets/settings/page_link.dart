import 'package:flutter/material.dart';

class PageLink extends StatelessWidget {
  final String title;
  final String subtitle;
  final String routeName;
  final Widget leading;
  final Widget trailing;

  PageLink(
    this.title, {
    @required this.routeName,
    this.subtitle,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(routeName),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      leading: leading,
      trailing: trailing,
    );
  }
}

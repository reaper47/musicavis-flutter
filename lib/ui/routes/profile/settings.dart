import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:musicavis/providers/theme.dart';
import 'package:musicavis/repository/boxes.dart';
import 'package:musicavis/ui/widgets/all.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/themes.dart';

class ProfileSettingsRoute extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ROUTE_PROFILE_SETTINGS_TITLE),
      ),
      body: ListView(
        children: [
          SectionTitle('Personalization'),
          DropdownTile(
            'Appearance',
            subtitle: 'Choose your preferred theme.',
            defaultValue: DARK_THEME_PREF,
            values: themesList,
            boxName: SETTINGS_BOX,
            settingKey: SETTINGS_THEME_KEY,
            onChange: (name) => context.read(themeStateNotifier).setTheme(name),
          ),
          SectionTitle('Practice'),
          InstrumentsTile(),
          BpmRangeTile(),
          DialogLink(
            'Minutes Max',
            subtitle: 'Set the upper bound for the number of minutes.',
            trailing: Icon(Icons.chevron_right),
            isBarrierDismissible: false,
            dialog: _numMinutesDialog(context),
          ),
          SectionTitle('Notifications'),
          SwitchTile(
            'Daily practice reminder',
            subtitle: 'Do you want to get reminded to play every day?',
            defaultValue: true,
            boxName: SETTINGS_BOX,
            settingKey: SETTINGS_NOTIFICATIONS_KEY,
          ),
          SectionTitle('Miscellaneous'),
          ListTile(
            title: Text('Enjoying the app?'),
            subtitle: Text('Leave us a review in the store.'),
            trailing: Icon(Icons.chevron_right),
            onTap: _redirectToStore,
          ),
          ListTile(
            title: Text('Send us an email'),
            subtitle: Text('Request features, report bugs or say hello.'),
            trailing: Icon(Icons.chevron_right),
            onTap: _sendEmail,
          ),
          ListTile(
            title: Text('About this software'),
            subtitle: Text('View the app version and legal information.'),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _numMinutesDialog(BuildContext context) {
    final controller = TextEditingController(
      text: Hive.box(SETTINGS_BOX).get(SETTINGS_MINUTES_MAX_KEY).toString(),
    );

    return AlertDialog(
      title: Text('Number of Minutes'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('Set the upper bound for the number of minutes.'),
            SimpleTextField(
              type: TextInputType.number,
              controller: controller,
            ),
          ],
        ),
      ),
      actions: cancelSaveButtons(context, () {
        var numMinutes = int.parse(controller.text);
        if (numMinutes <= 0) {
          numMinutes = 1;
          controller.text = '1';
        }
        Hive.box(SETTINGS_BOX).put(SETTINGS_MINUTES_MAX_KEY, numMinutes);
        Navigator.of(context).pop();
      }),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: APP_NAME,
      applicationIcon: FlutterLogo(),
      applicationLegalese: '©2020 www.musicavis.ca',
      applicationVersion: '1.0.0',
    );
  }

  void _redirectToStore() {
    LaunchReview.launch(
      androidAppId: 'com.musicavis.app',
      iOSAppId: '585027354',
    );
  }

  void _sendEmail() {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'macpoule@gmail.com',
      queryParameters: {'subject': '[Musicavis] About your app'},
    );
    launch(_emailLaunchUri.toString());
  }
}

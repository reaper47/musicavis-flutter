import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';
import 'package:preferences/preferences.dart';

import 'package:musicavis/providers/theme.dart';
import 'package:musicavis/utils/constants.dart';
import 'package:musicavis/utils/themes.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettingsRoute extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ROUTE_PROFILE_SETTINGS_TITLE),
      ),
      body: PreferencePage([
        PreferenceTitle('Personalization'),
        DropdownPreference(
          'Appearance',
          THEME_PREF,
          onChange: (name) => context.read(themeStateNotifier).setTheme(name),
          defaultVal: DARK_THEME_PREF,
          values: themesList,
          desc: 'Choose your preferred theme.',
        ),
        PreferenceTitle('Practice'),
        /*InstrumentsTile(),
        BpmRangeTile(),
        PreferenceDialogLink(
          'Minutes Max',
          desc: 'Set the upper bound for the number of minutes.',
          dialog: PreferenceDialog(
            [
              TextFieldPreference(
                '',
                EXERCISE_MINUTES_MAX_PREF,
                padding: const EdgeInsets.only(top: 8.0),
                autofocus: true,
                keyboardType: TextInputType.number,
                defaultVal: '',
                hintText:
                    'Default is ${PrefService.getString(EXERCISE_MINUTES_MAX_PREF)}',
                validator: (String str) {
                  try {
                    if (int.parse(str) <= 0) {
                      return 'Number must be greater than 1';
                    }
                  } catch (e) {
                    return 'Please specify a number.';
                  }
                  return null;
                },
              ),
            ],
            title: 'Number of minutes',
            cancelText: 'Cancel',
            submitText: 'Save',
            onlySaveOnSubmit: true,
          ),
          trailing: Icon(Icons.chevron_right),
          onPop: () => setState(() {}),
        ),*/
        PreferenceTitle('Notifications'),
        SwitchPreference(
          'Daily practice reminder',
          'notification_practice_reminder',
          defaultVal: true,
          desc: 'Do you want to get reminded to play every day?',
        ),
        PreferenceTitle('Miscellaneous'),
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
      ]),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rshb/settings_tab.dart';
import 'package:rshb/widgets.dart';

class ProfileTab extends StatelessWidget {
  static const title = 'Профиль';
  static const androidIcon = Icon(Icons.person);
  static const iosIcon = Icon(CupertinoIcons.profile_circled);

  const ProfileTab({Key? key}) : super(key: key);

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Text(
                  '😼',
                  style: TextStyle(
                    fontSize: 80,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            const PreferenceCard(
              header: 'Возраст',
              content: '⌛',
              preferenceChoices: [
                '10',
                '11',
                '12',
                '13',
                "14",
                '15',
                '16',
                '17',
                '18',
              ],
            ),
            const PreferenceCard(
              header: 'Город',
              content: '🏙',
              preferenceChoices: [
                'Москва',
                'Санкт-Петербург',
                'Новосибирск',
                'Екатеринбург',
                'Нижний Новгород',
                'Казань',
                'Челябинск',
                'Омск',
                'Ростов-на-Дону',
                'Уфа',
                'Красноярск',
                'Пермь',
                'Воронеж',
                'Самара',
                'Краснодар',
                'Волгоград',
                'Тюмень',
                'Тольятти',
                'Ижевск',
                'Барнаул',
                'Иркутск',
                'Ярославль',
                'Владивосток',
                'Хабаровск',
                'Махачкала',
                'Томск',
                'Оренбург',
                'Новокузнецк',
                'Кемерово',
                'Томск',
                'Ставрополь',
                'Ульяновск',
                'Астрахань',
                'Владимир',
                'Саратов',
                'Тула',
                'Тверь',
                'Киров',
                'Кострома',
                'Сургут',
                'Нижневартовск',
                'Брянск',
                'Рязань',
                'Калининград',
                'Вологда',
                'Саранск',
                'Калуга',
                'Тверь',
                'Смоленск',
                'Тула',
                'Тамбов',
                'Кострома',
                'Стерлитамак',
                'Курск',
                'Таганрог',
                'Сочи',
              ],
            ),
            Expanded(
              child: Container(),
            ),
            // const LogOutButton(),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // Non-shared code below because on iOS, the settings tab is nested inside of
  // the profile tab as a button in the nav bar.
  // ===========================================================================

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   trailing: CupertinoButton(
      //     padding: EdgeInsets.zero,
      //     child: SettingsTab.iosIcon,
      //     onPressed: () {
      //       // This pushes the settings page as a full page modal dialog on top
      //       // of the tab bar and everything.
      //       Navigator.of(context, rootNavigator: true).push<void>(
      //         CupertinoPageRoute(
      //           title: SettingsTab.title,
      //           fullscreenDialog: true,
      //           builder: (context) => const SettingsTab(),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      child: _buildBody(context),
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

class PreferenceCard extends StatelessWidget {
  const PreferenceCard({
    required this.header,
    required this.content,
    required this.preferenceChoices,
    Key? key,
  }) : super(key: key);

  final String header;
  final String content;
  final List<String> preferenceChoices;

  @override
  Widget build(context) {
    return PressableCard(
      color: Colors.green,
      flattenAnimation: const AlwaysStoppedAnimation(0),
      child: Stack(
        children: [
          SizedBox(
            height: 120,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                  content,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black12,
              height: 40,
              padding: const EdgeInsets.only(left: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                header,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {
        showChoices(context, preferenceChoices);
      },
    );
  }
}

class LogOutButton extends StatelessWidget {
  static const _logoutMessage = Text(
      "You can't actually log out! This is just a demo of how alerts work.");

  const LogOutButton({Key? key}) : super(key: key);

  // ===========================================================================
  // Non-shared code below because this tab shows different interfaces. On
  // Android, it's showing an alert dialog with 2 buttons and on iOS,
  // it's showing an action sheet with 3 choices.
  //
  // This is a design choice and you may want to do something different in your
  // app.
  // ===========================================================================

  Widget _buildAndroid(BuildContext context) {
    return ElevatedButton(
      child: const Text('LOG OUT', style: TextStyle(color: Colors.red)),
      onPressed: () {
        // You should do something with the result of the dialog prompt in a
        // real app but this is just a demo.
        showDialog<void>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Log out?'),
              content: _logoutMessage,
              actions: [
                TextButton(
                  child: const Text('Got it'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoButton(
      color: CupertinoColors.destructiveRed,
      child: const Text('Log out'),
      onPressed: () {
        // You should do something with the result of the action sheet prompt
        // in a real app but this is just a demo.
        showCupertinoModalPopup<void>(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              title: const Text('Log out?'),
              message: _logoutMessage,
              actions: [
                CupertinoActionSheetAction(
                  child: const Text('Reprogram the night man'),
                  isDestructiveAction: true,
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoActionSheetAction(
                  child: const Text('Got it'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                child: const Text('Cancel'),
                isDefaultAction: true,
                onPressed: () => Navigator.pop(context),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

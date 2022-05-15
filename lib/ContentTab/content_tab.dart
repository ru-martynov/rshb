import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets.dart';
import 'webview_tab.dart';

class ContentTab extends StatefulWidget {
  static const title = 'Материалы';
  static const androidIcon = Icon(Icons.extension);
  static const iosIcon = Icon(Icons.extension);

  const ContentTab({Key? key}) : super(key: key);

  @override
  _ContentTab createState() => _ContentTab();
}

PanelController _pc = new PanelController();

class _ContentTab extends State<ContentTab> {
  @override
  Widget _buildAndroid(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(ContentTab.title),
      ),
      // body: SlidingUpPanel(
      //   maxHeight: MediaQuery.of(context).size.height * .7,
      //   minHeight: MediaQuery.of(context).size.height * 0.05,
      //   controller: _pc,
      //   panel: const WebView(
      //     initialUrl:
      //         'https://yandex.ru/games/app/162531?utm_source=game_popup_menu',
      //   ),
      //   collapsed: Container(
      //     decoration:
      //         BoxDecoration(color: Colors.white, borderRadius: radius),
      //   ),
      //   borderRadius: radius,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                buildCard(
                    'Тест на тип личности',
                    'https://i.ytimg.com/vi/ER2LtbbTvPU/maxresdefault.jpg',
                    'https://www.16personalities.com/ru/test-lichnosti'),
                buildCard(
                    'Игра',
                    'https://image.winudf.com/v2/image1/Y29tLnNwaXJpdC5mYW1pbmdzaW11bGF0b3IucGxvd2Zhcm1pbmdzaW1fc2NyZWVuXzVfMTU4ODM1NjM3MF8wOTM/screen-10.jpg?fakeurl=1&type=.jpg',
                    'https://yandex.ru/games/app/162531?utm_source=game_popup_menu'),
                buildCard(
                    'Обзор колледжа РГСУ',
                    'https://topuch.ru/rossijskij-gosudarstvennij-socialenij-universitet-praktichesko-vfts1/330166_html_cfa6fc93b6f105d7.jpg',
                    'https://msk.postupi.online/ssuz/kolledzh-rgsu/'),
                buildCard(
                    'Новая олимпиада!',
                    'https://spbgau.ru/files/by_igavs_zen_logo.png',
                    'https://spbgau.ru/entering/agrarnaya_olimpiada_shkolnikov'),
              ],
            )),
      ),
    );
  }

  @override
  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text(ContentTab.title),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                buildCard(
                    'Тест на тип личности',
                    'https://i.ytimg.com/vi/ER2LtbbTvPU/maxresdefault.jpg',
                    'https://www.16personalities.com/ru/test-lichnosti'),
                buildCard(
                    'Игра',
                    'https://image.winudf.com/v2/image1/Y29tLnNwaXJpdC5mYW1pbmdzaW11bGF0b3IucGxvd2Zhcm1pbmdzaW1fc2NyZWVuXzVfMTU4ODM1NjM3MF8wOTM/screen-10.jpg?fakeurl=1&type=.jpg',
                    'https://yandex.ru/games/app/162531?utm_source=game_popup_menu'),
                buildCard(
                    'Обзор колледжа РГСУ',
                    'https://topuch.ru/rossijskij-gosudarstvennij-socialenij-universitet-praktichesko-vfts1/330166_html_cfa6fc93b6f105d7.jpg',
                    'https://msk.postupi.online/ssuz/kolledzh-rgsu/'),
                buildCard(
                    'Новая олимпиада!',
                    'https://spbgau.ru/files/by_igavs_zen_logo.png',
                    'https://spbgau.ru/entering/agrarnaya_olimpiada_shkolnikov'),
              ],
            )),
      ),
    );
  }

  Card buildCard(heading, image, _url) {
    var ran = Random();
    // var heading = '\$${(ran.nextInt(20) + 15).toString()}00 per month';
    return Card(
        elevation: 4.0,
        child: new InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WebViewApp(url: _url),
                ),
              );
            },
            child: Column(
              children: [
                ListTile(
                  title: Text(heading),
                ),
                Container(
                  height: 200.0,
                  child: Ink.image(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

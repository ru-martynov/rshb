import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'VideosTab/videos_tab.dart';
// import 'VideosTab/songs_tab.dart';
import 'NewsTab/news_tab.dart';
import 'ProfileTab/profile_tab.dart';
import 'settings_tab.dart';
import 'widgets.dart';
import 'ContentTab/content_tab.dart';

void main() => runApp(const MyAdaptingApp());

class MyAdaptingApp extends StatelessWidget {
  const MyAdaptingApp({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    // Either Material or Cupertino widgets work in either Material or Cupertino
    // Apps.
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MaterialApp(
        title: 'RSHB Next Generation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Use the green theme for Material widgets.
          primarySwatch: Colors.green,
        ),
        darkTheme: ThemeData.dark(),
        builder: (context, child) {
          return CupertinoTheme(
            // Instead of letting Cupertino widgets auto-adapt to the Material
            // theme (which is green), this app will use a different theme
            // for Cupertino (which is blue by default).
            data: const CupertinoThemeData(),
            child: Material(child: child),
          );
        },
        home: const PlatformAdaptingHomePage(),
      ),
    );
  }
}

// Shows a different type of scaffold depending on the platform.
//
// This file has the most amount of non-sharable code since it behaves the most
// differently between the platforms.
//
// These differences are also subjective and have more than one 'right' answer
// depending on the app and content.
class PlatformAdaptingHomePage extends StatefulWidget {
  const PlatformAdaptingHomePage({Key? key}) : super(key: key);

  @override
  _PlatformAdaptingHomePageState createState() =>
      _PlatformAdaptingHomePageState();
}

class _PlatformAdaptingHomePageState extends State<PlatformAdaptingHomePage> {
  // This app keeps a global key for the songs tab because it owns a bunch of
  // data. Since changing platform re-parents those tabs into different
  // scaffolds, keeping a global key to it lets this app keep that tab's data as
  // the platform toggles.
  //
  // This isn't needed for apps that doesn't toggle platforms while running.
  final videosTabKey = GlobalKey();

  // In Material, this app uses the hamburger menu paradigm and flatly lists
  // all 4 possible tabs. This drawer is injected into the songs tab which is
  // actually building the scaffold around the drawer.
  Widget _buildAndroidHomePage(BuildContext context) {
    return VideosPage(
      key: videosTabKey,
      androidNavigationBar: _AndroidNavigationBar(),
    );
  }

  // On iOS, the app uses a bottom tab paradigm. Here, each tab view sits inside
  // a tab in the tab scaffold. The tab scaffold also positions the tab bar
  // in a row at the bottom.
  //
  // An important thing to note is that while a Material Drawer can display a
  // large number of items, a tab bar cannot. To illustrate one way of adjusting
  // for this, the app folds its fourth tab (the settings page) into the
  // third tab. This is a common pattern on iOS.
  Widget _buildIosHomePage(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.green,
        backgroundColor: Colors.black87, //(0xFF212121),
        inactiveColor: Color(0xFFBDBDBD),
        height: 60,
        items: const [
          BottomNavigationBarItem(
            label: VideosPage.title,
            icon: VideosPage.iosIcon,
          ),
          BottomNavigationBarItem(
            label: NewsTab.title,
            icon: NewsTab.iosIcon,
          ),
          BottomNavigationBarItem(
            label: ContentTab.title,
            icon: ContentTab.iosIcon,
          ),
          BottomNavigationBarItem(
            label: ProfileTab.title,
            icon: ProfileTab.iosIcon,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              defaultTitle: VideosPage.title,
              builder: (context) => VideosPage(key: videosTabKey),
            );
          case 1:
            return CupertinoTabView(
              defaultTitle: NewsTab.title,
              builder: (context) => const NewsTab(),
            );
          case 2:
            return CupertinoTabView(
              defaultTitle: ContentTab.title,
              builder: (context) => const ContentTab(),
            );
          case 3:
            return CupertinoTabView(
              defaultTitle: ProfileTab.title,
              builder: (context) => const ProfileTab(),
            );
          default:
            assert(false, 'Unexpected tab');
            return const SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(context) {
    return PlatformWidget(
      androidBuilder: _buildAndroidHomePage,
      iosBuilder: _buildIosHomePage,
    );
  }
}

// class _AndroidNavigationBar extends StatelessWidget with 3
class _AndroidNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Colors.green,
          backgroundColor: Color(0xFF212121),
          inactiveColor: Color(0xFFBDBDBD),
          height: 60,
          items: const [
            BottomNavigationBarItem(
              label: VideosPage.title,
              icon: VideosPage.iosIcon,
            ),
            BottomNavigationBarItem(
              label: NewsTab.title,
              icon: NewsTab.iosIcon,
            ),
            BottomNavigationBarItem(
              label: ContentTab.title,
              icon: ContentTab.iosIcon,
            ),
            BottomNavigationBarItem(
              label: ProfileTab.title,
              icon: ProfileTab.iosIcon,
            ),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                defaultTitle: VideosPage.title,
                builder: (context) => VideosPage(),
              );
            case 1:
              return CupertinoTabView(
                defaultTitle: NewsTab.title,
                builder: (context) => const NewsTab(),
              );
            case 2:
              return CupertinoTabView(
                defaultTitle: ContentTab.title,
                builder: (context) => const ContentTab(),
              );
            case 3:
              return CupertinoTabView(
                defaultTitle: ProfileTab.title,
                builder: (context) => const ProfileTab(),
              );
            default:
              assert(false, 'Unexpected tab');
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

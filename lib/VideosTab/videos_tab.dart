import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:rshb/VideosTab/stories.dart';
import 'package:story_view/story_view.dart';
// import 'videos_detail_tab.dart';

import 'videos_detail_tab.dart';
import 'package:rshb/utils.dart';
import 'package:rshb/widgets.dart';

class VideosPage extends StatefulWidget {
  static const title = 'Видео';
  static const androidIcon = Icon(Icons.video_library);
  static const iosIcon = Icon(Icons.video_library);

  const VideosPage({Key? key, this.androidNavigationBar}) : super(key: key);

  final Widget? androidNavigationBar;

  @override
  _VideosTabState createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosPage> {
  static const _itemsLength = 50;

  final _androidRefreshKey = GlobalKey<RefreshIndicatorState>();

  final StoryController controller = StoryController();

  late List<MaterialColor> colors;
  late List<String> videosNames;

  @override
  void initState() {
    _setData();
    super.initState();
  }

  void _setData() {
    colors = getRandomColors(_itemsLength);
    videosNames = getRandomNames(_itemsLength);
  }

  Future<void> _refreshData() {
    return Future.delayed(
      // This is just an arbitrary delay that simulates some network activity.
      const Duration(seconds: 2),
      () => setState(() => _setData()),
    );
  }

  @override
  Widget _stories(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Delicious Ghanaian Meals"),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          margin: EdgeInsets.all(
            8,
          ),
          child: ListView(
            children: <Widget>[
              Container(
                height: 200,
                child: StoryView(
                  controller: controller,
                  storyItems: [
                    StoryItem.text(
                      title: "Эти сторисы для полезной информации",
                      backgroundColor: Colors.red.shade500,
                      roundedTop: true,
                    ),
                    StoryItem.text(
                      title: "Ну или можно рассказывать новости",
                      backgroundColor: Colors.blue,
                      roundedTop: true,
                    ),
                    StoryItem.text(
                      title: "Позже хочу реализовать с firebase ",
                      backgroundColor: Colors.green,
                      roundedTop: true,
                    ),
                    // StoryItem.inlineImage(
                    //   NetworkImage(
                    //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
                    //   caption: Text(
                    //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       backgroundColor: Colors.black54,
                    //       fontSize: 17,
                    //     ),
                    //   ),
                    // ),
                  ],
                  onStoryShow: (s) {
                    print("Showing a story");
                  },
                  onComplete: () {
                    print("Completed a cycle");
                  },
                  progressPosition: ProgressPosition.bottom,
                  repeat: false,
                  inline: true,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    //Переход на MoreStories() без rootNavigation
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => MoreStories(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(8))),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Посмотреть все",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listBuilder(BuildContext context, int index) {
    if (index >= _itemsLength) return Container();

    // Show a slightly different color palette. Show poppy-ier colors on iOS
    // due to lighter contrasting bars and tone it down on Android.
    final color = defaultTargetPlatform == TargetPlatform.iOS
        ? colors[index]
        : colors[index].shade400;

    return SafeArea(
      top: false,
      bottom: false,
      child: Hero(
        tag: index,
        child: HeroAnimatingVideosCard(
          videos: videosNames[index],
          color: color,
          heroAnimation: const AlwaysStoppedAnimation(0),
          onPressed: () => Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) => VideosDetailTab(
                id: index,
                videos: videosNames[index],
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _togglePlatform() {
    TargetPlatform _getOppositePlatform() {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        return TargetPlatform.android;
      } else {
        return TargetPlatform.iOS;
      }
    }

    debugDefaultTargetPlatformOverride = _getOppositePlatform();
    // This rebuilds the application. This should obviously never be
    // done in a real app but it's done here since this app
    // unrealistically toggles the current platform for demonstration
    // purposes.
    WidgetsBinding.instance!.reassembleApplication();
  }

  // ===========================================================================
  // Non-shared code below because:
  // - Android and iOS have different scaffolds
  // - There are differenc items in the app bar / nav bar
  // - Android has a hamburger drawer, iOS has bottom tabs
  // - The iOS nav bar is scrollable, Android is not
  // - Pull-to-refresh works differently, and Android has a button to trigger it too
  //
  // And these are all design time choices that doesn't have a single 'right'
  // answer.
  // ===========================================================================
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(VideosPage.title),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.shuffle),
          //   onPressed: () async =>
          //       await _androidRefreshKey.currentState!.show(),
          // ),
        ],
      ),
      bottomNavigationBar: widget.androidNavigationBar,
      body: RefreshIndicator(
        key: _androidRefreshKey,
        onRefresh: _refreshData,
        // Add the widget _stories() here under the SliverAppBar.
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              snap: false,
              floating: false,
              expandedHeight: 300,
              // pinned: true,
              // Add the widget _stories() here under the SliverAppBar.
              flexibleSpace: _stories(context),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                _listBuilder,
                childCount: _itemsLength,
              ),
            ),
          ],
        ),
      ),
    );
    //     child: ListView.builder(
    //       padding: const EdgeInsets.symmetric(vertical: 12),
    //       itemCount: _itemsLength,
    //       itemBuilder: _listBuilder,
    //     ),
    //   ),
    // );
  }

  Widget _buildIos(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Add the widget _stories() here under the SliverAppBar.
        SliverAppBar(
          elevation: 0,
          // actions: [
          //   IconButton(
          //       icon: const Icon(Icons.shuffle),
          //       onPressed: () async => Navigator.pop(context)),
          // ],
          expandedHeight: 270,
          flexibleSpace: FlexibleSpaceBar(
            background: _stories(context),
          ),
        ),
        CupertinoSliverNavigationBar(
          border: Border(bottom: BorderSide.none),
          largeTitle: const Text(VideosPage.title),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.shuffle),
            onPressed: _refreshData,
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: _refreshData,
        ),
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                _listBuilder,
                childCount: _itemsLength,
              ),
            ),
          ),
        ),
      ],
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

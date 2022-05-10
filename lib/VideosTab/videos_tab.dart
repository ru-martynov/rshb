import 'package:flutter/material.dart';
import 'package:rshb/VideosTab/stories.dart';
import 'package:story_view/story_view.dart';
import 'videos_detail_tab.dart';

void main() => runApp(VideosPage());

class VideosPage extends StatelessWidget {
  static const title = 'Видео';
  static const androidIcon = Icon(Icons.video_library);
  static const iosIcon = Icon(Icons.video_library);

  const VideosPage({Key? key, this.androidDrawer}) : super(key: key);

  final Widget? androidDrawer;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home());
  }
}

class Home extends StatelessWidget {
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                      context,
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
}

import 'package:flutter/material.dart';
import 'package:rshb/VideosTab/videos_tab.dart';
import 'package:story_view/story_view.dart';
import 'package:swipe/swipe.dart';

class MoreStories extends StatefulWidget {
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("More"),
      // ),
      body: Swipe(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: StoryView(
            storyItems: [
              StoryItem.text(
                title: "Чтобы закрыть сторис смахните вверх",
                backgroundColor: Colors.blue,
              ),
              StoryItem.text(
                title: "Обычные сторисы с цветом на фоне",
                backgroundColor: Colors.red,
                textStyle: TextStyle(
                  fontFamily: 'Dancing',
                  fontSize: 40,
                ),
              ),
              StoryItem.pageImage(
                url:
                    "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
                caption: "Still sampling",
                controller: storyController,
              ),
              StoryItem.pageImage(
                  url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
                  caption: "Working with gifs",
                  controller: storyController),
              StoryItem.pageImage(
                url:
                    "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
                caption: "Hello, from the other side",
                controller: storyController,
              ),
              StoryItem.pageImage(
                url:
                    "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
                caption: "Hello, from the other side2",
                controller: storyController,
              ),
            ],
            onStoryShow: (s) {
              print("Showing a story");
            },
            onComplete: () {
              print("Completed a cycle");
              Navigator.pop(context); //of(context)
              // .push(MaterialPageRoute(builder: (context) => VideosPage()));
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
          ),
        ),
        onSwipeUp: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => HomePage()));
          Navigator.pop(context);
        },
      ),
    );
  }
}

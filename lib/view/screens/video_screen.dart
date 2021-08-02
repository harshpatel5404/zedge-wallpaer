import 'package:flutter/material.dart';
import 'package:zedge/view/widgets/popular_view.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text("Wallpaper"),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: CustomScrollView(
            slivers: [
              PopularGridview(isVideo: true),
            ],
          ),
        ),
      ),
    );
  }
}

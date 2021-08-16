import 'package:flutter/material.dart';
import 'package:zedge/view/api/wall_model.dart';
import 'package:zedge/view/widgets/feature_view.dart';
import 'video_screen.dart';

List feturedWallpaper = [
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
  {"icon": Icons.image, "title": "winter time", "image": "assets/img1.jpg"},
  {"icon": Icons.verified, "title": "monsoon time", "image": "assets/img1.jpg"},
  {
    "icon": Icons.mark_as_unread,
    "title": " summer time",
    "image": "assets/img1.jpg"
  },
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
  {"icon": Icons.image, "title": "winter time", "image": "assets/img1.jpg"},
  {"icon": Icons.verified, "title": "monsoon time", "image": "assets/img1.jpg"},
  {
    "icon": Icons.mark_as_unread,
    "title": " summer time",
    "image": "assets/img1.jpg"
  },
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
  {"icon": Icons.image, "title": "winter time", "image": "assets/img1.jpg"},
  {"icon": Icons.verified, "title": "monsoon time", "image": "assets/img1.jpg"},
  {
    "icon": Icons.mark_as_unread,
    "title": " summer time",
    "image": "assets/img1.jpg"
  },
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
  {"icon": Icons.image, "title": "winter time", "image": "assets/img1.jpg"},
  {"icon": Icons.verified, "title": "monsoon time", "image": "assets/img1.jpg"},
  {
    "icon": Icons.mark_as_unread,
    "title": " summer time",
    "image": "assets/img1.jpg"
  },
  {"icon": Icons.verified, "title": "summer time", "image": "assets/img1.jpg"},
];

class FeatureList extends StatefulWidget {
  List<ImageResponse>? data;
  bool isloading;
  FeatureList({Key? key, this.data, required this.isloading}) : super(key: key);

  @override
  _FeatureListState createState() => _FeatureListState();
}

class _FeatureListState extends State<FeatureList> {

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VideoScreen()));
                },
                child: FeatureListView(
                  isloading: widget.isloading,
                  title: feturedWallpaper[index]["title"],
                  icon: feturedWallpaper[index]["icon"],
                  image: widget.data![index].urls!.small,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

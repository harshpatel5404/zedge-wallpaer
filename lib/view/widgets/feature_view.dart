import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zedge/view/screens/wallpaper_screenview.dart';

class FeatureListView extends StatefulWidget {
  final icon;
  bool isloading = true;
  final title;
  final image;
  FeatureListView(
      {Key? key, this.icon, this.title, this.image, required this.isloading})
      : super(key: key);

  @override
  _FeatureListViewState createState() => _FeatureListViewState();
}

class _FeatureListViewState extends State<FeatureListView> {
   void loaddata()  {
       setState(() {
         load = false;
       });
    }
@override
void initState() { 
  super.initState();
  load = true;
      Future.delayed(
          Duration(
            seconds: 3,
          ),loaddata);  
}
  @override
  Widget build(BuildContext context) {
  
 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: load
          ? Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.42,
                height: 100,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ))
          : Container(
              width: MediaQuery.of(context).size.width * 0.42,
              decoration: new BoxDecoration(
                        color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: new DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    left: 10,
                    child: Text(
                      widget.title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: new BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          widget.icon,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

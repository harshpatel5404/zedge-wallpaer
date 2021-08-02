import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:zedge/view/api/wall_model.dart';

class Craousal extends StatefulWidget {
   List<ImageResponse> ?data;
 Craousal({Key? key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CraousalState();
  }
}

class _CraousalState extends State<Craousal> {
  final List<String> images = [
    "https://source.unsplash.com/900x1600/?nature,water",
    "https://source.unsplash.com/900x1600/?waterfall",
    "https://source.unsplash.com/900x1600/?tree",
    "https://source.unsplash.com/900x1600/?cartoon",
    "https://source.unsplash.com/900x1600/?water",
  ];
  String? bgimag;
  

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      images.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String> createFolder(String wallpaper) async {
      final folderName = wallpaper;
      final path = Directory("storage/emulated/0/$folderName");
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if ((await path.exists())) {
        return path.path;
      } else {
        path.create();
        return path.path;
      }
    }


    _saveVideo() async {
      await Permission.storage.request();
     var savePath = await createFolder("wallpaper");
      savePath = savePath + "/temp1.jpeg";
      print("save $savePath");

      await Dio().download(
          "https://www.codegrepper.com/codeimages/how-to-push-data-to-array-in-dart.png",
          savePath);
      final result = await ImageGallerySaver.saveFile(savePath);
      print(result);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Container(
          decoration: new BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey, Colors.blueGrey],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.5, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: new NetworkImage(
                "$bgimag",
              ),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.more_vert,
                      size: 35,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              CarouselSlider.builder(
                itemCount: images.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.70,
                  viewportFraction: 0.65,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      bgimag = images[index];
                    });
                  },
                ),
                itemBuilder: (context, index, realIdx) {
                  return Container(
                    child: Center(
                        child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    )),
                  );
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () async {
                        print("share");
                        //  await ImageShare.shareImage(filePath: "https://www.codegrepper.com/codeimages/how-to-push-data-to-array-in-dart.png");
                        var save = await createFolder("wallpaper");
                        save = save+"/temp1.jpeg";
                        await Share.shareFiles(['$save'],
                            text: 'Wallpaper');
                      },
                      child: Icon(
                        Icons.share,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _saveVideo();
                        });
                      },
                      child: Icon(
                        Icons.download_for_offline_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

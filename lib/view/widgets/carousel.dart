import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:zedge/view/api/wall_model.dart';

class Craousal extends StatefulWidget {
  List<ImageResponse>? data;
  List? links;
  int? imgindex;
  Craousal({Key? key, this.data, this.links, this.imgindex}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CraousalState();
  }
}

class _CraousalState extends State<Craousal> {
  String? bgimag;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.links!.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";
  final List<String> images = [
    "https://source.unsplash.com/900x1600/?nature,water",
    "https://source.unsplash.com/900x1600/?waterfall",
    "https://source.unsplash.com/900x1600/?tree",
    "https://source.unsplash.com/900x1600/?cartoon",
    "https://source.unsplash.com/900x1600/?water",
  ];
  Stream<String>? progressString;
  String? res;
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    // print("widget urls ${widget.links}");
    // print("widget data ${widget.data}");
    var sliderindex = widget.imgindex! -1;

    Future<String> createFolder(String wallpaper) async {
      final folderName = wallpaper;
       final path = Directory("/storage/emulated/0/$folderName");
      //  print("manual path = ${path.path}");
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
   
    _saveImage() async {
      await Permission.storage.request();
      var savePath = await createFolder("wallpaper");
      savePath = savePath + "/zedge$sliderindex.jpeg";
      // print("savePath $savePath");
      await Dio().download(
          widget.links![sliderindex],
          savePath);
      final result = await ImageGallerySaver.saveFile(savePath);
      // print("result $result");
    }

    return widget.data == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.black,
            body: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                decoration: new BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.blue],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.dstATop),
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
                          InkWell(
                            onTap: () async {
                              try {
                                progressString =
                                    Wallpaper.ImageDownloadProgress(
                                        widget.links![sliderindex]);
                                progressString!.listen((data) {
                                  setState(() {
                                    res = data;
                                    downloading = true;
                                  });
                                }, onDone: () async {
                                  both = await Wallpaper.bothScreen();
                                  setState(() {
                                    downloading = false;
                                    both = both;
                                    lock = both;
                                  });
                                  // print("Task Done");
                                }, onError: (error) {
                                  setState(() {
                                    downloading = false;
                                  });
                                  print("Some Error");
                                });
                              } catch (e) {
                                print("error is $e");
                              }
                            },
                            child: Icon(
                              Icons.more_vert,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                      itemCount: widget.links!.length,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.70,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        
                      ),
                      itemBuilder: (context, index, realIdx) {
                       print("slider index $sliderindex");

                        if(sliderindex <= 29 && sliderindex >= 0  ){
                           sliderindex++;
                         if (sliderindex == 29) {
                          sliderindex = 1;
                           
                         }
                        }

                       

                        return Container(
                          child: Center(
                              child: Image.network(
                            widget.links![sliderindex-1],
                            height: MediaQuery.of(context).size.height * 0.70,
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
                              // print("share");
                              await _saveImage();
                              var save = "storage/emulated/0/wallpaper/zedge$sliderindex.jpeg";
                              // print("save =  $save");
                              await Share.shareFiles(['$save'], text: 'Wallpaper');
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
                                _saveImage();
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

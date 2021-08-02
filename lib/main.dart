import 'package:flutter/material.dart';
import 'view/screens/notifications_screen.dart';
import 'view/screens/ringtones_screen.dart';
import 'view/screens/video_wallpaper.dart';
import 'view/screens/wallpaper_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
       
        routes: {
          '/wallpaper': (context) => WallpaperScreen(),
          '/videowallpaper': (context) => VideoWallpaperScreen(),
          '/ringtones': (context) => Ringtonescreen(),
          '/notifications': (context) => NotificationScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Wallpaper App',
        home: WallpaperScreen());
  }
}

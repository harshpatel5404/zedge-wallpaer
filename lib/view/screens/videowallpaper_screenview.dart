import 'package:flutter/material.dart';
import 'package:zedge/view/api/server_comunication.dart';
import 'package:zedge/view/api/wall_model.dart';
import 'package:zedge/view/screens/feature_list.dart';
import 'package:zedge/view/widgets/categories_gridview.dart';
import 'package:zedge/view/widgets/popular_view.dart';
import 'package:zedge/view/widgets/title_widget.dart';
import 'package:zedge/view/widgets/wallpaper_categories.dart';

class VideoWallpaperTabView extends StatelessWidget {
  const VideoWallpaperTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ImageResponse>>(
      future: getResponse(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ImageResponse>> snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data != null ||
            snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data!;
          return TabBarView(
            children: [
              CustomScrollView(
                semanticChildCount: 1,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                      child: HeadingWidget(
                    title: "Featured",
                  )),
                  SliverToBoxAdapter(
                    child: FeatureList(
                      data: data,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: HeadingWidget(
                      title: "Popular",
                    ),
                  ),
                  PopularGridview(
                    data: data,
                    isVideo: true,
                  )
                ],
              ),
              CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: WallpaperCategories(
                      data: data,
                    ),
                  ),
                  Categoriesgrid(
                    
                  ),
                ],
              ),
              CustomScrollView(
                slivers: [
                  PopularGridview(
                    data: data,
                    isVideo: true,
                  )
                ],
              )
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

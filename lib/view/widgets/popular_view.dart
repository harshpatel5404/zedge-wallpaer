import 'package:flutter/material.dart';
import 'package:zedge/view/api/wall_model.dart';
import 'package:zedge/view/widgets/carousel.dart';

class PopularGridview extends StatelessWidget {
 final bool isVideo;
   List<ImageResponse> ?data;
  PopularGridview({Key? key,  required this.isVideo, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {

        return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.5,
        mainAxisSpacing: 6,
      ),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Craousal(data :data)));
              print(index);
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: NetworkImage(data![index].urls!.small.toString()),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
             isVideo ?Positioned(
                  bottom: 15,
                  left: 15,
                  child: Container(
                    alignment: Alignment.center,
                    height: 17,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.videocam,
                          size: 15,
                          color: Colors.black,
                        )),
                  ),
                ) : SizedBox()
              ],
            ),
          ),
        );
      },
       childCount: data!.length),
    );
  }
}

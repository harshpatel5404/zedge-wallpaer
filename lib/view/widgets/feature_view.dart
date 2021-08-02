import 'package:flutter/material.dart';


class FeatureListView extends StatelessWidget {
  final icon;
  final title;
  final image;
  const FeatureListView({Key? key, this.icon, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        decoration: new BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          image: new DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,

          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 5,
              left: 10,
              child:Text(title,style: TextStyle(color:Colors.white),) ,
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
                  child: Icon(icon,size: 20,color: Colors.white,),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

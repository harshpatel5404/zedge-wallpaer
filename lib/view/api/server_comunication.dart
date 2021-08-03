import 'package:http/http.dart' as http;
import 'package:zedge/view/api/wall_model.dart';

String url =
    "https://api.unsplash.com/photos?client_id=C1g0wg37kJ2Xvr6cHerGhPUDCOxcyRLtpPZu1fJKlFI";

Future <List<ImageResponse>> getResponse () async{
  
  try {
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      // print("response ${response.body}");
      final List<ImageResponse> imgUrl = imageResponseFromJson(response.body);
      // print("imgUrl $imgUrl");
      return imgUrl;
    }
    else{
      List<ImageResponse> imgUrl = [];
      return imgUrl;
    }
  } catch (e) {
    print("error is $e");
      List<ImageResponse> imgUrl = [];
      return imgUrl;
  }
}
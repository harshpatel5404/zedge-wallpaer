import 'package:http/http.dart' as http;
import 'package:zedge/view/api/wall_model.dart';

String url =
    "https://api.unsplash.com/photos?per_page=50&client_id=C1g0wg37kJ2Xvr6cHerGhPUDCOxcyRLtpPZu1fJKlFI";
String query="https://api.unsplash.com/search/photos?per_page=30&query=nature&client_id=3HzERgtDIRkOj9GJyEkW6hGruPQztdhLYHJHyEB8dPQ";

Future <List<ImageResponse>> getResponse () async{
  
  try {
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final List<ImageResponse> imgUrl = imageResponseFromJson(response.body);
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
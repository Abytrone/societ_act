import 'package:http/http.dart' as http;
import 'package:societ_act/models/posts_class.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Post>?> fetchProducts() async {
    var response = await client
        .get(Uri.parse('http://fakeapi.jsonparseronline.com/posts'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}

import 'package:get/state_manager.dart';
import 'package:societ_act/models/posts_class.dart';
import 'package:societ_act/services/remote_services.dart';

class PostsController extends GetxController {
  var isLoading = true.obs;
  var postsList = <Datum>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      var posts = await RemoteServices.fetchPosts();
      if (posts != null) {
        postsList.value = posts.data;
        // for (var i in posts.data) {
        //   Datum post = Datum(
        //     id: i.id,
        //     type: i.type,
        //     attributes: i.attributes,
        //   );
        //   postsList.add(post);
        // }
      } else {
        isLoading(false);
        return null;
      }
    } finally {
      isLoading(false);
    }
  }
}

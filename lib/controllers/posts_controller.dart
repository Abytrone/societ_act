import 'package:get/state_manager.dart';
import 'package:societ_act/models/posts_class.dart';
import 'package:societ_act/utils/remote_services.dart';

class PostsController extends GetxController {
  var isLoading = true.obs;
  var postList = <Post>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var post = await RemoteServices.fetchProducts();
      if (post != null) {
        postList.value = post;
      }
    } finally {
      isLoading(false);
    }
  }

  // Post(
  //   fullname: '',
  //   username: '',
  //   userImage: '',
  //   postImage: '',
  //   postText: '',
  //   postTitle: '',
  //   likes: '',
  // ),
}

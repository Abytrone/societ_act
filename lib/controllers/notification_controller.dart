import 'package:get/state_manager.dart';
import 'package:societ_act/models/notification_class.dart';
import 'package:societ_act/services/remote_services.dart';

class NotificationsController extends GetxController {
  var isLoading = true.obs;
  var notificationList = <Notify>[].obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading(true);
      var notifi = await RemoteServices.fetchNotifications();
      if (notifi != null) {
        notificationList.value = notifi;
        // for (var i in posts.data) {
        //   Datum post = Datum(
        //     id: i.id,
        //     type: i.type,
        //     attributes: i.attributes,
        //   );
        //   postsList.add(post);
        // }
        isLoading(false);
      } else {
        isLoading(false);
        return null;
      }
    } finally {
      isLoading(false);
    }
  }
}

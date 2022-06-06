import 'package:get/get.dart';
import 'package:task_list/modules/create_update/create_update_controller.dart';

class CreateUpdateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUpdateController>(() => CreateUpdateController());
  }
}

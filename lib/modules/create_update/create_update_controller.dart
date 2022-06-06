import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:task_list/common/enum.dart';
import 'package:task_list/common/uitl.dart';
import 'package:task_list/data/service/task_service.dart';
import 'package:uuid/uuid.dart';
import '../../data/model/task_model.dart';
import '../auth/auth_service.dart';
import '../home/home_controller.dart';

class CreateUpdateController extends GetxController {
  RxBool isLoading = true.obs;
  RxString titlePage = ActionType.update.toValue().obs;
  var task = Task(
    uid: AuthService.instance.getUser().uid,
    taskId: const Uuid().v4(),
    isDone: false,
    createdDateTime: Get.find<HomeController>().daySelected.value.toyyyyMMdd(),
    updatedDateTime: Get.find<HomeController>().daySelected.value.toyyyyMMdd(),
  ).obs;
  @override
  void onInit() {
    if (Get.arguments[Task.tableName] == null) {
      titlePage.value = ActionType.create.toValue();
    } else {
      task.value = Get.arguments[Task.tableName];
    }
    isLoading.value = false;

    super.onInit();
  }

  Future<void> attackTask({
    required String title,
    required String detail,
  }) async {
    try {
      if (title == '') {
        Get.snackbar(
          "Notification",
          "Please input title",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        var _task = task.value.copyWith(
          title: title,
          detail: detail,
        );
        if (titlePage.value == ActionType.create.toValue()) {
          await TaskService.createTask(_task);
        } else {
          var taskUpdate = (Get.arguments[Task.tableName] as Task)
              .copyWith(title: title, detail: detail);
          await TaskService.updateTask(taskUpdate);
        }
        Get.back();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      Get.back();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_list/data/service/task_service.dart';
import 'package:task_list/modules/auth/auth_service.dart';
import '../../data/model/task_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;

  var format = CalendarFormat.week.obs;
  var daySelected = DateTime.now().obs;
  @override
  void onInit() {
    isLoading.value = false;
    super.onInit();
  }

  createTodo() {
    Get.toNamed("create_update", arguments: {Task.tableName: null});
  }

  Future<void> checkedTask({required Task task, required value}) async {
    var _task = task.checked(isDone: value);
    await TaskService.updateTask(_task);
    Get.snackbar(
      "Notification",
      "Successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  askLogout() async {
    bool result = false;
    result = await Get.defaultDialog(
        title: 'Logout',
        content: const Text('Do you want to logout?'),
        textCancel: 'No',
        onCancel: () {
          Get.back(result: false);
        },
        textConfirm: 'Yes',
        onConfirm: () {
          Get.back(result: true);
        });
    if (result) {
      AuthService.instance.signOut();
    }
  }

  void onDaySelected(DateTime value) {
    daySelected.value = value;
  }

  void onChangeFormat(CalendarFormat value) {
    format.value = value;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_list/common/uitl.dart';
import 'package:task_list/common/widget/item.dart';
import 'package:task_list/data/model/task_model.dart';
import 'package:task_list/data/service/task_service.dart';
import 'package:task_list/modules/home/home_controller.dart';

class CompleteController extends GetxController {
  CompleteController({required this.taskService});
  final TaskService taskService;
  var itemList = <Widget>[].obs;
  var taskList = <Task>[].obs;
  RxBool isLoading = true.obs;
  RxInt pendingRebuild = 0.obs;

  @override
  void onInit() {
    ever(Get.find<HomeController>().daySelected, (_) {
      buildWidget();
    });
    buildWidget();
    super.onInit();
  }

  void buildWidget() {
    loadData();
    everAll([taskList], (_) {
      pendingRebuild++;
    });
    interval(pendingRebuild, (_) {
      itemList.clear();
      itemList.addAll(_arrangeList(taskList));
    }, time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    itemList.clear();
    super.onClose();
  }

  void loadData() {
    var data = taskService
        .loadData(Get.find<HomeController>().daySelected.value.toyyyyMMdd());
    taskList.bindStream(data);
  }

  List<Widget> _arrangeList(List<Task> _todoList) {
    var _itemList = <Widget>[];
    if (_todoList.isEmpty) {
      _itemList.add(const SizedBox.shrink());
      return _itemList;
    }

    for (var todo in _todoList) {
      _itemList.add(Item(task: todo));
    }
    return _itemList;
  }
}

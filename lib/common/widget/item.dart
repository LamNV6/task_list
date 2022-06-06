import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:task_list/data/model/task_model.dart';
import 'package:task_list/modules/home/home_controller.dart';

class Item extends StatelessWidget {
  const Item({required this.task, Key? key}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed("create_update", arguments: {Task.tableName: task});
        },
        child: Card(
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(width: 1, color: Colors.green)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(task.detail!),
                        ],
                      ))),
              GFCheckbox(
                size: GFSize.SMALL,
                activeBgColor: GFColors.DANGER,
                onChanged: (value) async {
                  await Get.find<HomeController>()
                      .checkedTask(task: task, value: value);
                },
                value: task.isDone,
              ),
            ],
          ),
        ));
  }
}

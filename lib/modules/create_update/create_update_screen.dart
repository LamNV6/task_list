import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:task_list/modules/create_update/create_update_controller.dart';

class CreateUpdateScreen extends GetView<CreateUpdateController> {
  const CreateUpdateScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CreateUpdateController>();

    var titleController =
        TextEditingController(text: controller.task.value.title);
    var detailController =
        TextEditingController(text: controller.task.value.detail);
    return Scaffold(
        appBar: GFAppBar(
          leading: GFIconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
            type: GFButtonType.transparent,
          ),
          searchBar: true,
          title: Obx((() => Text(controller.titlePage.value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w300)))),
          actions: <Widget>[
            GFIconButton(
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () async {
                await controller.attackTask(
                  title: titleController.text,
                  detail: detailController.text,
                );
              },
              type: GFButtonType.transparent,
            ),
          ],
        ),
        body: GetX<CreateUpdateController>(
          builder: (_) {
            if (_.isLoading.value) {
              return const Loader(type: GFLoaderType.circle);
            } else {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: titleController,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(hintText: 'Title'),
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      TextFormField(
                        controller: detailController,
                        decoration: const InputDecoration(hintText: 'Detail'),
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      )
                    ],
                  ));
            }
          },
        ));
  }
}

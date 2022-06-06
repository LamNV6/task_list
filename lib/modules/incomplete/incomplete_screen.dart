import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'incomplete_controller.dart';

class IncompleteScreen extends StatelessWidget {
  const IncompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<IncompleteController>(builder: (controller) {
      if (controller.itemList.isEmpty) {
        return const GFLoader(type: GFLoaderType.circle);
      } else {
        return Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: controller.itemList.length,
                    itemBuilder: ((context, index) {
                      return controller.itemList[index];
                    }))),
          ],
        );
      }
    });
  }
}

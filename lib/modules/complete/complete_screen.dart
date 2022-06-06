import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'complete_controller.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CompleteController>(builder: (controller) {
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

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do/app/core/utils/extensions.dart';
import 'package:to_do/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  final homeCrtl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCrtl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(2.5.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCrtl.editController.clear();
                        homeCrtl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      onPressed: () {
                        if (homeCrtl.formKey.currentState!.validate()) {
                          if (homeCrtl.task.value == null) {
                            EasyLoading.showError('Please select your task type');
                          } else {
                            var success = homeCrtl.updateTask(
                              homeCrtl.task.value!,
                              homeCrtl.editController.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess(
                                  'To-do item added to task successfully');
                              Get.back();
                              homeCrtl.changeTask(null);
                            } else {
                              EasyLoading.showError('To-do item already exists');
                            }
                            homeCrtl.editController.clear();
                          }
                        }
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 14.0.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.5.wp),
                child: Text(
                  'New Task',
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.5.wp),
                child: TextFormField(
                  controller: homeCrtl.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your to-do item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 5.0.wp,
                  left: 6.5.wp,
                  right: 6.5.wp,
                  bottom: 2.0.wp,
                ),
                child: Text(
                  'Add to',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCrtl.tasks
                  .map((element) => Obx(() => InkWell(
                        onTap: () => homeCrtl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.5.wp,
                            vertical: 3.0.wp,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(
                                      element.icon,
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(width: 3.0.wp),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (homeCrtl.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                            ],
                          ),
                        ),
                      )))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

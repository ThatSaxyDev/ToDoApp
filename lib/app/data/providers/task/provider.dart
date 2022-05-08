import 'dart:convert';

import 'package:get/get.dart';
import 'package:to_do/app/core/utils/keys.dart';
import 'package:to_do/app/data/models/task.dart';
import 'package:to_do/app/data/services/storage/service.dart';

class TaskProvider {
 final StorageService _storage = Get.find<StorageService>();

// MODEL FOR REFERENCE IN LOCAL STORAGE
// {'tasks':[
//   {'title': 'Work',
//   'color': '#ff.....',
//   'icon': 0xe123
//   }
// ]}

  // READ TASK METHOD
  List<Task> readTask() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  // WRITE TASK METHOD
  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}

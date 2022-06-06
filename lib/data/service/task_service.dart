import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../modules/auth/auth_service.dart';
import '../model/task_model.dart';

class TaskService {
  Stream<List<Task>> loadData(String date) async* {
    try {
      var query = FirebaseFirestore.instance.collection(Task.tableName).where(
          Task.uidColumnName,
          isEqualTo: AuthService.instance.getUser().uid);
      var query1 = query.where(Task.isDoneColumnName, isEqualTo: true);
      var query2 = query1
          .where(Task.createdDateTimeColumnName, isEqualTo: date)
          .snapshots()
          .map((e) => e.docs
              .map((x) => Task.fromJson(
                    x.data(),
                  ))
              .toList());
      yield* query2;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Stream<List<Task>> loadIncompleteData(String date) async* {
    try {
      var query = FirebaseFirestore.instance.collection(Task.tableName).where(
          Task.uidColumnName,
          isEqualTo: AuthService.instance.getUser().uid);
      var query1 = query.where(Task.isDoneColumnName, isEqualTo: false);
      var query2 = query1
          .where(Task.createdDateTimeColumnName, isEqualTo: date)
          .snapshots()
          .map((e) => e.docs
              .map((x) => Task.fromJson(
                    x.data(),
                  ))
              .toList());
      yield* query2;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> updateTask(Task task) async {
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection(Task.tableName)
        .where(Task.taskIdColumnName, isEqualTo: task.taskId)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    DocumentReference docRef = doc.reference;
    await docRef.update(task.toJson());
  }

  static Future<void> createTask(Task task) async {
    await FirebaseFirestore.instance
        .collection(Task.tableName)
        .add(task.toJson());
  }
}

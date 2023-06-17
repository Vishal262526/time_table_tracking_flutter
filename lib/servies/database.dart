import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_table_tracker_flutter/models/task.dart';

class Database {
  static final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  Future<bool> addTask(String subject, String description, DateTime date,
      TimeOfDay startTime, TimeOfDay endTime) async {
    final Task taskModel = Task(
      uid: uid,
      subject: subject,
      description: description,
      date: DateFormat.yMMMd().format(date),
      startTime:
          "${startTime.hour} : ${startTime.minute}",
      endTime:
          "${endTime.hour} : ${endTime.minute}",
    );

    try {
      final DocumentReference addTaskStatus = await _firestore
          .collection("users")
          .doc(uid)
          .collection("tasks")
          .add(taskModel.toJson());
      await addTaskStatus.update({"document_id": addTaskStatus.id});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot>? getTasks(DateTime date) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("tasks")
        .where(
          "date",
          isEqualTo: DateFormat.yMMMd().format(date),
        )
        .snapshots();
  }

  Future<bool> deleteTask(String documentId) async {
    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("tasks")
          .doc(documentId)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> updateTaskToComplete(String documentId, bool completeStatus) async {
    try {
      
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("tasks")
          .doc(documentId)
          .update({"completed": completeStatus ? false : true});
      return {"success":true, "msg":completeStatus ? "Task: Mark as In Progress" :"Task: Mark as Complete"};
    } catch (e) {
      return {"success":false, "err":e.toString()};
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TaskController extends GetxController {
  TextEditingController taskInfoController = TextEditingController();
  var selectedDate = ''.obs;
  var selectedCategory = [].obs;
  RxBool isCheck = false.obs;
  RxString priority = 'Low'.obs;
  RxString categoryType = 'College Work'.obs;
  var dueDate = 'DateTime.now()'.obs;
  
  var todoList = [].obs;

  static void check(String title, bool? value) {}
  
}

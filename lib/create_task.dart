import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/controller/task_controller.dart';
import 'category_list.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  //----------------------------------------
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        fieldHintText: "11-10-2001");
    if (picked != null && picked != selectedDate) selectedDate = picked;
    taskController.selectedDate.value =
        DateFormat('dd-MM-yyyy').format(selectedDate);
  }

  //----------------------------------------
  // Your existing todoList

  DateTime selectedDate = DateTime.now();
  final TaskController taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
            // title: Text('Create Task'),
            ),
        body: Column(children: [
          Container(
            height: 25,
            width: MediaQuery.of(context).size.width * 0.98,
            child: const Center(
              child: Text(
                'Create Task',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
                controller: taskController.taskInfoController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Task Information',
                ),
                validator: (title) {
                  if (title == null || title.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
          ),
          SizedBox(height: 10),
          Text(' Due Date: ${
              // taskController.selectedDate.today ?:
              taskController.selectedDate.value}'),
          SizedBox(
            height: 10,
          ),
          OutlinedButton.icon(
            onPressed: () {
              _selectDate(context);
            },
            label: const Text('Due Date'),
            icon: const Icon(Icons.calendar_month),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                 
                  value: taskController.isCheck.value,
                  onChanged: (value) {
                    taskController.isCheck.value =
                        !taskController.isCheck.value;
                    value = taskController.isCheck.value;
                    print("${taskController.isCheck.value}");
                  }),
              const Text('Completed'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton.icon(
            onPressed: () {},
            label: const Text('Priority'),
            icon: const Icon(Icons.priority_high),
          ),
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () {
                taskController.priority.value = 'Low';
              },
              child: Text(
                'Low',
                style: TextStyle(
                    color: taskController.priority.contains('low')
                        ? Colors.black
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor: taskController.priority.contains('low')
                      ? MaterialStateProperty.all(Colors.green[200])
                      : MaterialStateProperty.all(Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                taskController.priority.value = 'Medium';
                // Get.to(() => adduserPopup(context));
              },
              child: Text(
                'Medium',
                style: TextStyle(
                    color: taskController.priority.contains('Medium')
                        ? Colors.black
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor: taskController.priority.contains('Medium')
                      ? MaterialStateProperty.all(Colors.yellow[100])
                      : MaterialStateProperty.all(Colors.white)),
            ),
            ElevatedButton(
              onPressed: () {
                taskController.priority.value = 'High';
              },
              child: Text(
                'High',
                style: TextStyle(
                    color: taskController.priority.contains('high')
                        ? Colors.black
                        : Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor: taskController.priority.contains('high')
                      ? MaterialStateProperty.all(Colors.red[200])
                      : MaterialStateProperty.all(Colors.white)),
            )
          ]),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: OutlinedButton.icon(
                onPressed: () {},
                label: const Text('Category'),
                icon: const Icon(Icons.category)),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            child: Wrap(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(
                  children: [
                    ...categoryList.map(
                      (e) => category(
                          name: e['name'],
                          onTap: () {
                            // final bool isExits = taskController.selectedCategory
                            //     .contains(e['name']);

                            // !isExits
                            //     ? taskController.selectedCategory.add(e['name'])
                            //     : taskController.selectedCategory
                            //         .removeWhere((item) => item == e['name']);

                            // print("${taskController.selectedCategory}");

                            taskController.categoryType.value = e['name'];
                          },
                          color: taskController.categoryType.value == e['name']
                              ? Colors.red
                              : Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            onPressed: () {
              Map<String, dynamic> newTodo = {
                'title': taskController.taskInfoController.text,
                'date': taskController.selectedDate.value,
                'isCheck': taskController.isCheck.value,
                'priority': taskController.priority.value,
                'category': taskController.categoryType.value
                // 'category': taskController.selectedCategory
              };
              taskController.todoList.add(newTodo);
              print("**************$newTodo");
              print(">>>>>>>>>>>>>>${taskController.todoList}");

              Get.back();
            },
            label: const Text(
              'New Task',
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(Icons.arrow_drop_up)),
      ),
    );
  }

  Widget category(
      {required name, required VoidCallback onTap, required Color color}) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: onTap,
            child: Text(
              name,
              style: TextStyle(color: color),
            ))
      ],
    );
  }

  String convertDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    // return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}

Future adduserPopup(context) {
  return showDialog(
    context: context,
    builder: (context) {
      var taskController;
      return AlertDialog(
          content: Container(
              height: 234,
              width: 110,
              child: Column(children: [
                //name
                TextFormField(
                    controller: taskController.taskInfoController,
                    decoration: InputDecoration(
                        labelText: "Enter your category",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    validator: (value) {
                      if (!RegExp('[a-z A-Z]').hasMatch(value!)) {
                        return "Enter Correct Name";
                      } else {
                        return null;
                      }
                    }),
              ])));
    },
  );
}

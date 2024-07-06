import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_line/progress_line.dart';

import 'package:todoapp/create_task.dart';

import 'controller/task_controller.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
            ), // Set menu icon at leading of AppBar
          ),
          body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: taskCard(context: context)),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.to(() => CreateTask());
            },
            label: Icon(Icons.add),
          ),
        ));
  }
}

Widget categoryCard({required category}) {
  return SingleChildScrollView(
    child: Container(
      margin: EdgeInsets.all(10),
      height: 120,
      width: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            // color: Colors.greenAccent[200],
            offset: const Offset(
              2.0,
              2.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: const Text('Task : 1',style: TextStyle(fontSize: 15),),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Text(
              "$category",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: ProgressLineWidget(percent: 0.8)
          )
        ],
      ),
    ),
  );
}

Widget taskCard({required BuildContext context}) {
  var taskController = Get.put(TaskController());
  return SingleChildScrollView(
    child: Column(children: [
      Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(
          left: 25,
        ),
        height: 30,
        width: MediaQuery.of(context).size.width * 0.98,
        // color: Colors.amber,
        child: const Text(
          "CATEGORIES",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...taskController.todoList.map(
              (e) => categoryCard(
                category: e["category"] ?? '',
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 25),
      Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(
          left: 25,
        ),
        height: 30,
        width: MediaQuery.of(context).size.width * 0.98,
        // color: Colors.amber,
        child: const Text(
          "TASKS TO DO",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(height: 10),
      Column(children: [
        ...taskController.todoList.map((e) => tCard(
            context: context,
            title: e["title"] ?? '',
            date: e["date"] ?? '',
            category: e["category"] ?? '',
            Priority: e["priority"] ?? '',
            check: e["isCheck"] ?? '',
            onDelete: () {
              taskController.todoList.removeWhere(e['title'] ?? '');
              print(taskController.todoList);
            }))
      ])
    ]),
  );
}

Widget tCard(
    {required BuildContext context,
    required String title,
    required String category,
    required String date,
    required String Priority,
    required bool check,
    required VoidCallback onDelete}) {
  var taskController = Get.put(TaskController());
  return Container(
      margin: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.98,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              // color: Colors.greenAccent[200],
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
          borderRadius: BorderRadius.zero),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Checkbox(
                  value: taskController.isCheck.value,
                  onChanged: (value) {
                    taskController.isCheck.value =
                        !taskController.isCheck.value;
                    value = taskController.isCheck.value;
                    print("${taskController.isCheck.value}");
                
                  },
                  side: BorderSide(color: Colors.pink, width: 2),
                ),
              ),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.amber,
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      "$title",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      softWrap: true,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600,
                        decoration: taskController.isCheck.value
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 4),
                    child: Text(
                      "Due Date : $date",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
              Container(
                  padding: EdgeInsets.only(top: 15),
                  child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        "$Priority",
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.pink, width: 2)))),
              // SizedBox(height: 5),
              // InkWell(
              //     onTap: onDelete,
              //     child: Icon(
              //       Icons.delete,
              //       color: Colors.red,
              //     ))
            ],
          ),
        )
      ]));
}

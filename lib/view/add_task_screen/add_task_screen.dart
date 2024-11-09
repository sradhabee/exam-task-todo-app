import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_task_to_do/controller/to_do_controller.dart';


import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final taskController = TextEditingController();
    final CollectionReference tasksCollection = FirebaseFirestore.instance.collection('tasks');
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD TODOS!!!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: "Add New Task",
                hintStyle: TextStyle(color: Colors.blue,fontSize: 18),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 60,
            ),
        
            ElevatedButton(onPressed: (){
              final title = taskController.text;
              if(title.isNotEmpty){
                Provider.of<ToDoController>(context, listen: false).addTask(title);
                Navigator.pop(context);
              }
            }, child: Text("Save",style: TextStyle(color: Colors.blue),)
            ),
          ],
        ),
      ),
    );
  }
}
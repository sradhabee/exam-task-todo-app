import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_task_to_do/controller/to_do_controller.dart';
import 'package:exam_task_to_do/view/add_task_screen/add_task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDoListScreen extends StatelessWidget {
  const ToDoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProviderObj = Provider.of<ToDoController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO LIST APP",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 73, 186, 238),
        onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen(),));
      },child: Icon(Icons.add),),
      body: StreamBuilder(stream:todoProviderObj.tasksStream , builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final tasks = snapshot.data!.docs;
          return ListView.separated(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                
                title: Text(task['title'],style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                decoration: task['completed']?TextDecoration.lineThrough:TextDecoration.none),),
                leading: Checkbox(
                  checkColor: Colors.white,
                  side: BorderSide(color: Colors.blue),
                  
                  fillColor: MaterialStatePropertyAll(Colors.blue),
                  
                  value: task['completed'], onChanged: (value) {
                  todoProviderObj.toggleAction(task.id, task['completed']);
                },
               ),
               onLongPress: () {
                 showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text("DELETE"),
              
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Colors.blue,height: 3,thickness: 3,),
                      SizedBox(height: 12,),
                      Text("Are you Sure?",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),),

                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("Cancel",style: TextStyle(color: Colors.blue),)),
                          
                          ElevatedButton(onPressed: (){
                            todoProviderObj.deleteTask(task.id);
                            Navigator.pop(context);
                          }, child: Text("Delete",style: TextStyle(color: Colors.blue),)),
                        ],
                      ),
                      
                    ],
                  )
                 ),);
               }, );
            
          }, separatorBuilder: (BuildContext context, int index) { return Divider(color: Colors.black,endIndent: 12,indent: 12,) ;},);
          }),
    );
  }

}
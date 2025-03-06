import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   
   addTodo(Todo todo){
      context.read<TodoBloc>().add(
        AddTodo(todo: todo)
        );
   }

   removeTodo(Todo todo){
     context.read<TodoBloc>().add(
      RemoveTodo(todo: todo)
     );
   }

   alterTodo(Todo index){
    context.read<TodoBloc>().add(
       AlterTodo(index: index)
    );
   }

  @override
  Widget build(BuildContext context) {
      
      TextEditingController controller1 = TextEditingController();
      TextEditingController controller2 = TextEditingController(); 

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('To Do app', style: GoogleFonts.aBeeZee(
            color: Colors.black12,
            fontSize: 24,
            fontWeight: FontWeight.w800
        ),
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state){
             if(state.status == TodoStatus.success){
                return Container();
             }else if(state.status == TodoStatus.initial){
              return CircularProgressIndicator();
             }else{
              return Container();
             }
        }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context){
              return  AlertDialog(
                title: Text("Add new Task"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                       controller: controller1,
                  ),
                    TextField(
                       controller: controller1,
                  ),
                  ]
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: Text("cancel")
                        ),
                      ElevatedButton(
                        onPressed: (){}, 
                        child: Text("Update")
                        ),
                    ],
                  )
                ],
              );
            }
            );
        },
        child: Icon(Icons.add),
        ),
    );
  }
}
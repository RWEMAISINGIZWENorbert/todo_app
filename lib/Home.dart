import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
      backgroundColor: Colors.red[800],
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
                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                      return Card(
                         elevation: 1,
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)
                         ),
                         child: Slidable(
                          key: const ValueKey(0),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(), 
                            children: [
                              SlidableAction(
                                onPressed: (_) => removeTodo(state.todos[index]),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white70,
                                icon: Icons.delete,
                                label: 'delete',
                                )
                            ]
                            ),
                          child: ListTile(
                            title: Text(state.todos[index].title),
                            subtitle: Text(state.todos[index].subTitle),
                          ),
                         ),
                      );
                  }
                  );
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
                       controller: controller2,
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
                        onPressed: (){
                          addTodo(
                            Todo(title: controller1.text, subTitle: controller2.text)
                          );
                        }, 
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
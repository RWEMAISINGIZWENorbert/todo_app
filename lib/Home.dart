import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';
import 'package:todo_app/ThemeBloc/theme_bloc.dart';
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

      final List<(String, ThemeMode)> themes = [
        ('light', ThemeMode.light),
        ('dark', ThemeMode.dark),
        ('system', ThemeMode.system),
      ];

    return  Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('To Do app', style: Theme.of(context).textTheme.titleMedium,   ),
          actions:  <Widget>[
              Builder(
                builder: (innerContext) {
                  return BlocBuilder<ThemeCubit, ThemeMode>(
                    buildWhen: (previousStae, currentState) => previousStae != currentState,
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                           showPopover(
                            arrowHeight: 0, // Removes the arrow
                            arrowWidth: 0, //Removes the arrow
                            backgroundColor: Theme.of(context).cardColor,
                            context: context, 
                            barrierDismissible: true,
                            width: 210,
                            height: 200,
                            direction: PopoverDirection.top,
                            bodyBuilder: (context) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 18),
                                  alignment:  Alignment.center,
                                  child: Column(
                                    children: List.generate(
                                      themes.length, (index){
                                         final String label = themes[index].$1;
                                          ThemeMode theme = themes[index].$2;
                                          return ListTile(
                                              onTap:  () => context.read<ThemeCubit>().updateTheme(theme),
                                              title: Text(label, style: Theme.of(context).textTheme.labelMedium,),
                                              trailing: state == theme ? Icon(Icons.check, color:Theme.of(context).hintColor,) : null,
                                          );
                                      }
                                      ),
                                  ),
                                );
                            }
                            );
                        },
                        child: Container(
                          padding: EdgeInsets.only(right: 18),
                          child: Icon(Icons.settings, color: Theme.of(context).hintColor,
                          )
                          ),
                      );
                    }
                  );
                }
              )
          ],
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state){
               if(state.status == TodoStatus.success){
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                        return Card(
                           elevation: 1,
                           color: Theme.of(context).cardColor,
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
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
                              titleTextStyle: Theme.of(context).textTheme.labelMedium,
                              subtitleTextStyle: Theme.of(context).textTheme.labelSmall,
                            ),
                           ),
                        );
                    }
                    );
               }else if(state.status == TodoStatus.loading){
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
                  backgroundColor: Theme.of(context).cardColor,
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            }, 
                            child: Text("cancel", style: Theme.of(context).textTheme.labelSmall,),
                            ),
                          GestureDetector(
                            onTap: (){
                              addTodo(
                                Todo(title: controller1.text, subTitle: controller2.text)
                              );
                              Navigator.of(context).pop();
                            }, 
                            child: Container(
                              padding: EdgeInsets.symmetric( horizontal:  18, vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.green[700],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text("Save", style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300
                              ),)
                              )
                            ),
                        ],
                      ),
                    )
                  ],
                );
              }
              );
          },
          elevation: 0,
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Icon(Icons.add, color: Theme.of(context).hintColor,),
          ),
      );
  }
}
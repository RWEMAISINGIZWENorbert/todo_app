import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/Home.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';

void main() async {

 WidgetsFlutterBinding.ensureInitialized();

  final directory = await getTemporaryDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(directory as String),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: BlocProvider<TodoBloc>(
          create: (context) => TodoBloc()..add(
            TodoStarted()
            ),
            child: Home(),
          )
    );
  }
}

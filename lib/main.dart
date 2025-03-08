
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/Home.dart';
import 'package:todo_app/ThemeBloc/theme_bloc.dart';
import 'package:todo_app/themeData/themeData.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final directory = await getApplicationDocumentsDirectory();xx
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorageDirectory.web
          : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
          providers: [
            BlocProvider<TodoBloc>(
              create: (context) => TodoBloc()..add(TodoStarted()),
            ),
            BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit(),
            ),
          ], 
            child: BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, state){
                  return MaterialApp(
                            debugShowCheckedModeBanner: false,
                          theme: lightMode,
                      darkTheme: darkMoode,
                       themeMode: state,
                       home: Home(),
                  );
                }
                ),
        );
        // );
  }
}

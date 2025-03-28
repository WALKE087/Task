import 'package:crud/data/datasources/remote_task_datasource.dart';
import 'package:crud/data/repositories/task_repositories_imp.dart';
import 'package:crud/domain/usecases/create_task.dart';
import 'package:crud/domain/usecases/delete_task.dart';
import 'package:crud/domain/usecases/get_tasks.dart';
import 'package:crud/domain/usecases/update_task.dart';
import 'package:crud/presentation/controller/task_controller.dart';
import 'package:crud/presentation/view/list_tareas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(
    TaskController(
      getTasks: GetTasks(TaskRepositoryImpl(RemoteTaskDataSource())),
      createTask: CreateTask(TaskRepositoryImpl(RemoteTaskDataSource())),
      updateTask: UpdateTask(TaskRepositoryImpl(RemoteTaskDataSource())),
      deleteTask: DeleteTask(TaskRepositoryImpl(RemoteTaskDataSource())),
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crud Tareas',
      home: ListTareas(),
    );
  }
}

import 'package:get/get.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';

class TaskController extends GetxController {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  var tasks = <Task>[].obs;
  var isLoading = false.obs;

  TaskController({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  });

  Future<void> fetchTasks() async {
    isLoading.value = true;

    try {
      tasks.value = await getTasks();
    } catch (e) {
      // print("Error al obtener tareas: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(Task task) async {
    await createTask(task);
    await fetchTasks();
  }

  Future<void> modifyTask(Task task) async {
    await updateTask(task);
    await fetchTasks();
  }

  Future<void> removeTask(int id) async {
    await deleteTask(id);
    await fetchTasks();
  }
}

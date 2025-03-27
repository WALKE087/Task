import '../../domain/entities/task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';

class TaskController {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskController({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
  });

  Future<List<Task>> fetchTasks() async {
    return await getTasks();
  }

  Future<void> addTask(Task task) async {
    await createTask(task);
  }

  Future<void> modifyTask(Task task) async {
    await updateTask(task);
  }

  Future<void> removeTask(int id) async {
    await deleteTask(id);
  }
}

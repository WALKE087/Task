import '../models/task_model.dart';

class LocalTaskDataSource {
  List<TaskModel> tasks = [];

  Future<List<TaskModel>> getTasks() async {
    return tasks;
  }

  Future<void> createTask(TaskModel task) async {
    tasks.add(task);
  }

  Future<void> updateTask(TaskModel updatedTask) async {
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
    }
  }

  Future<void> deleteTask(int id) async {
    tasks.removeWhere((task) => task.id == id);
  }
}

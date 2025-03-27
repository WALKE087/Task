import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/local_task_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final LocalTaskDataSource dataSource;

  TaskRepositoryImpl(this.dataSource);

  @override
  Future<List<Task>> getTasks() async {
    return dataSource.getTasks();
  }

  @override
  Future<void> createTask(Task task) async {
    final taskModel = TaskModel(
      id: task.id,
      nombre: task.nombre,
      detalle: task.detalle,
      estado: task.estado,
    );
    await dataSource.createTask(taskModel);
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskModel = TaskModel(
      id: task.id,
      nombre: task.nombre,
      detalle: task.detalle,
      estado: task.estado,
    );
    await dataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(int id) async {
    await dataSource.deleteTask(id);
  }
}

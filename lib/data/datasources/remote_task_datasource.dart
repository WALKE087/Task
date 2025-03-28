import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class RemoteTaskDataSource {
  // final String baseUrl = "https://nk0blh78-8000.use2.devtunnels.ms";
  final String baseUrl = "https://localhost:7183";

  Future<List<TaskModel>> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tareas'));

    // print(
    //   "Respuesta de la API: ${response.statusCode} - ${response.body}",
    // );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener las tareas: ${response.body}');
    }
  }

  Future<void> createTask(TaskModel task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tareas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear la tarea');
    }
  }

  Future<TaskModel> getTaskById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/tareas/$id'));

    if (response.statusCode == 200) {
      return TaskModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener la tarea');
    }
  }

  Future<void> updateTask(TaskModel task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tareas/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la tarea');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tareas/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la tarea');
    }
  }
}

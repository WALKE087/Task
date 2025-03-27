import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required int id,
    required String nombre,
    required String detalle,
    required String estado,
  }) : super(id: id, nombre: nombre, detalle: detalle, estado: estado);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      nombre: json['nombre'],
      detalle: json['detalle'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'detalle': detalle,
      'estado': estado,
    };
  }
}

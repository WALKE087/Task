import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    super.id,
    required super.nombre,
    required super.detalle,
    required super.estado,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      nombre: json['nombre'],
      detalle: json['detalle'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre, 'detalle': detalle, 'estado': estado};
  }
}

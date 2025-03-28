import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/controller/task_controller.dart';
import '../../domain/entities/task.dart';

class ListTareas extends StatefulWidget {
  @override
  _ListTareasState createState() => _ListTareasState();
}

class _ListTareasState extends State<ListTareas> {
  final TaskController controller = Get.find<TaskController>();
  String filtroEstado = "Todos";

  @override
  Widget build(BuildContext context) {
    controller.fetchTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Tareas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(197, 0, 86, 234),
        elevation: 4,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.filter_list,
              color: Colors.white,
            ), // 🔹 Icono de filtro
            onSelected: (value) {
              setState(() {
                filtroEstado = value;
              });
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: "Todos", child: Text("Todos")),
                  PopupMenuItem(value: "Pendiente", child: Text("Pendiente")),
                  PopupMenuItem(
                    value: "En Progreso",
                    child: Text("En Progreso"),
                  ),
                  PopupMenuItem(value: "Completado", child: Text("Completado")),
                ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        var tareasFiltradas =
            controller.tasks.where((task) {
              return filtroEstado == "Todos" || task.estado == filtroEstado;
            }).toList();

        if (tareasFiltradas.isEmpty) {
          return Center(child: Text("No hay tareas disponibles"));
        }

        return ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 80),
          itemCount: tareasFiltradas.length,
          itemBuilder: (context, index) {
            final task = tareasFiltradas[index];
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 15,
                      child: Text(
                        task.id.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _getEstadoColor(task.estado),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        task.estado,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  task.nombre,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(task.detalle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showEditTaskDialog(context, task),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.removeTask(task.id!);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Color _getEstadoColor(String estado) {
    switch (estado.toLowerCase()) {
      case "pendiente":
        return Colors.orange;
      case "en progreso":
        return Colors.blue;
      case "completado":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showAddTaskDialog(BuildContext context) {
    TextEditingController nombreController = TextEditingController();
    TextEditingController detalleController = TextEditingController();
    String estadoSeleccionado = "Pendiente";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nueva Tarea"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: detalleController,
                decoration: InputDecoration(labelText: "Descripción"),
              ),
              DropdownButton<String>(
                value: estadoSeleccionado,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    estadoSeleccionado = newValue;
                  }
                },
                items:
                    ["Pendiente", "En Progreso", "Completado"]
                        .map(
                          (estado) => DropdownMenuItem(
                            value: estado,
                            child: Text(estado),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final nuevaTarea = Task(
                  nombre: nombreController.text,
                  detalle: detalleController.text,
                  estado: estadoSeleccionado,
                );
                controller.addTask(nuevaTarea);
                Navigator.of(context).pop();
              },
              child: Text("Agregar"),
            ),
          ],
        );
      },
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task) {
    TextEditingController nombreController = TextEditingController(
      text: task.nombre,
    );
    TextEditingController detalleController = TextEditingController(
      text: task.detalle,
    );
    String estadoSeleccionado = task.estado;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Editar Tarea"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
              TextField(
                controller: detalleController,
                decoration: InputDecoration(labelText: "Descripción"),
              ),
              DropdownButton<String>(
                value: estadoSeleccionado,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    estadoSeleccionado = newValue;
                  }
                },
                items:
                    ["Pendiente", "En Progreso", "Completado"]
                        .map(
                          (estado) => DropdownMenuItem(
                            value: estado,
                            child: Text(estado),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                final tareaEditada = Task(
                  id: task.id,
                  nombre: nombreController.text,
                  detalle: detalleController.text,
                  estado: estadoSeleccionado,
                );
                controller.modifyTask(tareaEditada);
                Navigator.of(context).pop();
              },
              child: Text("Actualizar"),
            ),
          ],
        );
      },
    );
  }
}

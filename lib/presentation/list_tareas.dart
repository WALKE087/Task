import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTareas extends StatelessWidget {

  ListTareas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
        actions: [
          GestureDetector(
            onTap: () => Get.to(""),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: badges.Badge(
                // ${cc.productCount}
              badgeContent:Obx(()=> Text('listaTarea')),
              // shopping_cart
              child: Icon(Icons.people),
              ),
          )
      )],
      ),
    );
  }

}
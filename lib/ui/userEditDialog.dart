import 'package:flutter/material.dart';
import 'package:app_sem14_s1/database/database.dart';
import 'package:drift/drift.dart' as dr;
import 'package:provider/provider.dart';

class UserEditDialog{
  final txtNombre = TextEditingController();
  final txtCorreo = TextEditingController();

  Widget buildDialog(BuildContext context, User user){
    AppDatabase database = Provider.of<AppDatabase>(context);
    txtNombre.text = user.nombre;
    txtCorreo.text = user.correo;
    return AlertDialog(
      title: const Text('Edit User'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtNombre,
              decoration: InputDecoration(
                  hintText: 'Type name'
              ),
            ),
            TextField(
              controller: txtCorreo,
              decoration: InputDecoration(
                  hintText: 'Type email'
              ),
            ),
            ElevatedButton(
              onPressed: (){
                database.updateUser(UsersCompanion(
                  id: dr.Value(user.id),
                  nombre: dr.Value(txtNombre.text),
                  correo: dr.Value(txtCorreo.text),
                ));
                Navigator.pop(context);
              },
              child: Text('Grabar'),
            )
          ],
        ),
      ),
    );
  }
}
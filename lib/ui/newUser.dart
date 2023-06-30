import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as dr;
import 'package:app_sem14_s1/database/database.dart';
import 'package:provider/provider.dart';

class newUser extends StatefulWidget {
  const newUser({super.key});

  @override
  State<newUser> createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  late AppDatabase database;
  late TextEditingController txtNombre;
  late TextEditingController txtCorreo;


  @override
  void initState() {
    super.initState();
    txtNombre = TextEditingController();
    txtCorreo = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('Usuario Nuevo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: txtNombre,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                hintText: "Ingrese Nombre",
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: txtCorreo,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                hintText: "Ingrese Correo",
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: (){
              database.insertUser(UsersCompanion(
                nombre: dr.Value(txtNombre.text),
                correo: dr.Value(txtCorreo.text)
              ))
                  .then((value) {
                    Navigator.pop(context,true);
              });
            },
            child: Text('Grabar usuario...'),
          )
        ],
      )
    );
  }
}

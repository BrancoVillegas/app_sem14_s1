import 'package:app_sem14_s1/ui/newUser.dart';
import 'package:drift/drift.dart' as dr;
import 'package:app_sem14_s1/ui/userEditDialog.dart';
import 'package:flutter/material.dart';
import 'package:app_sem14_s1/database/database.dart';
import 'package:provider/provider.dart';

class listUser extends StatefulWidget {
  const listUser({super.key});

  @override
  State<listUser> createState() => _listUserState();
}

class _listUserState extends State<listUser> {

  late AppDatabase database;
  UserEditDialog ? dialog;

  @override
  void initState() {
    super.initState();
    dialog = UserEditDialog();
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
      ),
      body: FutureBuilder<List<User>>(
        future: database.getListUsers(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<User>? userList = snapshot.data;
            return ListView.builder(
              itemCount: userList!.length,
              itemBuilder: (context, index){
                User userData = userList[index];
                return Dismissible(
                  key: Key(userData.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10.0),
                    child: const Icon(Icons.delete_outline_rounded, color: Colors.white,),
                  ),
                  secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 10.0),
                      child: const Icon(Icons.delete_outline_rounded, color: Colors.white)
                  ),
                  onDismissed: (direction) async {
                    await database.deleteUser(UsersCompanion(
                      id: dr.Value(userData.id),
                      nombre: dr.Value(userData.nombre),
                      correo: dr.Value(userData.correo),
                    )).then((value) => {
                      userList.removeAt(index),
                      setState(() {}),
                    });
                    //make a snack bar with the undo button
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuario eliminado'),
                        action: SnackBarAction(
                          label: 'Deshacer',
                          onPressed: () async {
                            await database.insertUser(UsersCompanion(
                              nombre: dr.Value(userData.nombre),
                              correo: dr.Value(userData.correo),
                            )).then((value) => {
                              setState(() {}),
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(userData.nombre),
                    subtitle: Text(userData.correo),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => dialog!.buildDialog(context, userData)).then((value) => {
                          setState(() {})
                        });
                      },
                    ),
                  ),
                );
              },
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addUser,
        backgroundColor: Colors.black54,
        child: const Icon(Icons.plus_one, color: Colors.white,),
      ),
    );
  }

  void addUser() async{
    var res = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => newUser()
    ),
    ).then((value) => {
      setState(() {})
    });
  }
}

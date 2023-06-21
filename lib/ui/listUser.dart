import 'package:app_sem14_s1/ui/newUser.dart';
import 'package:drift/drift.dart';
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
                  itemBuilder: (context,index){
                  User userData = userList[index];
                  return ListTile(
                    title: Text(userData.nombre),
                    subtitle: Text(userData.correo),
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
              child: Text(""),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addUser();
        },
        backgroundColor: Colors.black54,
        child: Icon(
          Icons.plus_one,
          color: Colors.white10,
        ),
      ),
    );
    return const Placeholder();
  }

  void addUser() async {
    var res = await Navigator.push(
      context, MaterialPageRoute(
        builder: (context)=> newUser()),
    );

    if(res !=null && res == true){
      setState(() {

      });
    }
  }
}

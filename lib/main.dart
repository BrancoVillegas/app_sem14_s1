import 'package:flutter/material.dart';
import 'package:app_sem14_s1/ui/listUser.dart';
import 'package:app_sem14_s1/database/database.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red
        ),
        home: listUser(),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc/screens/drawer_screen.dart';
import 'package:todo_bloc/screens/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(214, 47, 244, 1),
        onPressed: (){
          context.go('/taskAdd');
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
        ),
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
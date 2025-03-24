import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc/pages/home_page.dart';
import 'package:todo_bloc/pages/task_add.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/taskAdd',
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: '/taskAdd',
          builder: (context, state) => TaskAdd(),
        ),
      ]);
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
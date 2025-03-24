import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';
import 'package:todo_bloc/components/category_list.dart';
import 'package:todo_bloc/components/task_list_ui.dart';
import 'package:todo_bloc/models/category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerOpen = false;
  List<bool> isCheckedList = [false, false, false, false, false];   
  double xOffset = 0.0;
  double yOffset = 0.0;
  double scaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      width: width,
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? 0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(58, 78, 156, 1),
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: Column(
        children: [
          // Header section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isDrawerOpen) {
                        xOffset = 0;
                        yOffset = 0;
                        scaleFactor = 1;
                        isDrawerOpen = false;
                      } else {
                        xOffset = 230;
                        yOffset = 150;
                        scaleFactor = 0.6;
                        isDrawerOpen = true;
                      }
                    });
                  },
                  icon: Icon(
                    isDrawerOpen ? Icons.arrow_back_ios : Icons.menu,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search, color: Colors.white)),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          
          // Categories section
          SizedBox(
            height: height * 0.32,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What's up, Olivia!",
                    style: GoogleFonts.dmSerifText(fontSize: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'CATEGORIES',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: Category.tasksCategory.length,
                      itemBuilder: (context, index) {
                        final category = Category.tasksCategory[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: CategoryList(
                            category: category.category,
                            number: category.number,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Divider with "TODAY'S TASK" text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "TODAY'S TASK",
                    style: GoogleFonts.dmSerifText(
                      fontSize: 20, 
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          // Tasks list section
          Flexible(
            child: SingleChildScrollView(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  if (state is TodoLoaded) {
                    if (state.todos.isEmpty) {
                      return Center(
                        child: Text(
                          'No ToDo Data Added',
                          style: GoogleFonts.dmSerifText(
                            fontSize: 20, 
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    
                    return Column(
                    children: List.generate(state.todos.length, (index) {
                      final todo = state.todos[index];
                      return TaskListUi(
                        text: todo.title,
                        ischecked: todo.isCompleted,
                        onChanged: (value) {
                          context.read<TodoBloc>().add(LoadsTodos());
                        },
                      );
                    }),
                  );
                  }
                  
                  if (state is TodoError) {
                    return Center(
                      child: Text(
                        'Error: ${state.message}',
                        style: GoogleFonts.dmSerifText(
                          fontSize: 20, 
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  
                  return const Center(
                    child: Text('No Added Task'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
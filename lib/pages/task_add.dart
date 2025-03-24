import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_event.dart';
import 'package:todo_bloc/bloc/todo_state.dart';
import 'package:todo_bloc/data/todo_database.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TaskAdd extends StatefulWidget {
  const TaskAdd({super.key});

  @override
  State<TaskAdd> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  TextEditingController taskController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  late DateTime selectedDate;
  late DateTime focusedDate;

  @override
  void initState() {
    selectedDate = DateTime.now();
    focusedDate = DateTime.now();
    super.initState();
  }

  void addTask() {
  try {
    final taskTitle = taskController.text.trim();
    final taskDetails = detailsController.text.trim();

    if (taskTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task Title Cannot be empty')),
      );
      return;
    }

    var uuid = Uuid();
    final newTodo = TodoModel(
      id: uuid.v4(),
      title: taskTitle,
      details: taskDetails,
      isCompleted: false,
      time: selectedDate,
    );

    context.read<TodoBloc>().add(AddTodo(newTodo));
    debugPrint("Task Added: ${newTodo.title}, ${newTodo.details}");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Task Added SuccessFully'), // ✅ Show actual error message
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  } catch (e, stacktrace) {
    debugPrint("Error Adding Task: $e");
    debugPrint("Stacktrace: $stacktrace");

     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text('Failed to add task: $e'), // ✅ Show actual error message
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}


  Future<void> selectDate() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 480,
            width: 400,
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: focusedDate,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                      focusedDate = focusedDay;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    alignment: Alignment.center,
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text('Select'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          focusNode1.unfocus();
          focusNode2.unfocus();
        },
        child: SingleChildScrollView( // ✅ Prevents RenderFlex issue
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Tasks',
                  style: GoogleFonts.dmSerifText(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  focusNode: focusNode1,
                  controller: taskController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Task.....',
                    hintStyle: GoogleFonts.dmSerifText(fontSize: 15, color: Colors.grey.shade500),
                    suffixIcon: IconButton(
                      onPressed: taskController.clear, // ✅ No need for setState()
                      icon: const Icon(Icons.clear, size: 20, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await TodoDatabase.instance.deleteDatabase();
                    print('Database deleted successfully!');
                  },
                  child: Text('Reset Database'),
                ),

                TextField(
                  focusNode: focusNode2,
                  controller: detailsController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: 'Details.....',
                    hintStyle: GoogleFonts.dmSerifText(fontSize: 15, color: Colors.grey.shade500),
                    suffixIcon: IconButton(
                      onPressed: detailsController.clear, // ✅ No need for setState()
                      icon: const Icon(Icons.clear, size: 20, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade500),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 10),
                        Text(
                          'Select Date',
                          style: GoogleFonts.dmSerifText(fontSize: 20, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: addTask,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    alignment: Alignment.center,
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      'Add Task',
                      style: GoogleFonts.dmSerifText(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoLoaded) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            context.go('/home');
          } else if (state is TodoError) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Error'), 
                content: Text('Failed to add task.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context), 
                    child: const Text('OK'),
                  ),
              ],
              ),
            );
          }
        },
        child: const SizedBox.shrink(),
      ),
    );
  }
}

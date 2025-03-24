import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/data/todo_database.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoDatabase dbHelper = TodoDatabase.instance;

  TodoBloc() : super(TodoInitial()) {
    on<LoadsTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

 void _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
  try {
    await dbHelper.insertTodo(event.todo);
    debugPrint("Task added to DB: ${event.todo.title}");
    add(LoadsTodos());  // Reload todos after adding a new one
  } catch (e) {
    debugPrint("Error adding task: $e");
    emit(TodoError("Failed to add todo: $e"));
  }
}

void _onLoadTodos(LoadsTodos event, Emitter<TodoState> emit) async {
  emit(TodoLoading());
  try {
    final todos = await dbHelper.getTodos();
    debugPrint("Loaded Todos: $todos");
    emit(TodoLoaded(todos));
  } catch (e) {
    debugPrint("Error loading todos: $e");
    emit(TodoError("Failed to load todos: $e"));
  }
}


  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    await dbHelper.updateTodo(event.todo);
    add(LoadsTodos());
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    await dbHelper.deleteTodo(event.id);
    add(LoadsTodos());
  }
}

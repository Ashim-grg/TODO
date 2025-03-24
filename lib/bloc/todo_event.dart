import 'package:equatable/equatable.dart';
import 'package:todo_bloc/models/todo_model.dart';

abstract class TodoEvent extends Equatable{
    const TodoEvent();

    @override
    List<Object?> get props=>[];
    
}

class LoadsTodos extends TodoEvent{}
class AddTodo extends TodoEvent{
    final TodoModel todo;
    
    const AddTodo(this.todo);

    @override
    List<Object?> get props=>[];

}

class UpdateTodo extends TodoEvent{
  final TodoModel todo;
  const UpdateTodo(this.todo);

  @override
  List<Object?> get props=>[];
}
class DeleteTodo extends TodoEvent{
  final String id;
  const DeleteTodo(this.id);

  @override
  List<Object?> get props=>[];
}

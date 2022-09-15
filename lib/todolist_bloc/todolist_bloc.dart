import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw7/model/todolist_model.dart';

class TodoListCubit extends Cubit<String> {
    TodoListCubit() : super('');

  List<TodoList> todoLists = [];
  String abc = "";
  void addTodoList(String date, String content) {
    todoLists.add(TodoList(content, date,false));
    abc = todoLists.toString();
    emit(abc);
   // print('Save: $todoLists');
  }

  void onTapItem(String timer){
    for(int i=0;i<todoLists.length;i++){
        if(todoLists[i].time.contains(timer)){
          if(todoLists[i].isTap==false){
            todoLists[i].isTap = true;
          }
          else{
            todoLists[i].isTap = false;
          }
         }else{
          todoLists[i].isTap = false;
        }
        // if(todoLists[i].isTap==true){
        //   todoLists[i].isTap == false;
        // }
        //
        //
        // if(!todoLists[i].time.contains(timer)){
        //   todoLists[i].isTap == false;
        // }
    }
    print('onTap: $todoLists');
  }

  void removeTodoList(String timer) {
    if(todoLists.isNotEmpty){
      todoLists.removeWhere((element) => element.time == timer);
      abc = todoLists.toString();
      emit(abc);
    }
    //  print('Remove: $todoLists');

  }
}

// class TodoList {
//   final String content;
//   final String time;
//   TodoList(this.content, this.time);
// }

//
// class TodoListState {}
//
// class TodoListInitState extends TodoListState {}
//
// class TodoListSuccessState extends TodoListState {}
//
// class TodoListGettingState extends TodoListState {}
//
// class TodoListFailState extends TodoListState {}
//
// class TodoListEmptyState extends TodoListState {}

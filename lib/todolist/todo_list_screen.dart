import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhw7/model/todolist_model.dart';
import 'package:flutterhw7/todolist_bloc/todolist_bloc.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoListCubit _todoListCubit = TodoListCubit();
  late List<TodoList> todoList;
  final TextEditingController _controller = TextEditingController();
  var selItem='';
  //bool onTounch = false;
  // @override
  // void initState() {
  //   _todoListCubit.saveTodoList('', '');
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
        actions: [
          IconButton(
            onPressed: () {
              DateTime dateTime = DateTime.now();
              if(_controller.text.isNotEmpty){
                _todoListCubit.addTodoList(
                    dateTime.toIso8601String(), _controller.text);
                _controller.text = '';
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Check input"),
                ));
              }

              //_todoListCubit.createTodoList();
              //initState();
            },
            icon: const Icon(Icons.add_circle),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              if(selItem!=''){
                _todoListCubit.removeTodoList(selItem);
                selItem='';
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Chose item"),
                ));
              }

            },
            icon: const Icon(Icons.remove_circle),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
              maxLines: 1,
              controller: _controller,
              onSubmitted: (val) {
                _controller.text = val.toString();
              },
              onChanged: (val) {
                _controller.text = val.toString();
              }),
          SingleChildScrollView(
            child: BlocBuilder<TodoListCubit, String>(
                bloc: _todoListCubit,
                builder: (_, state) {
                  // if(_todoListCubit.todoList.isEmpty){
                  //   return Container();
                  // }
                  // if(_todoListCubit.todoList.isNotEmpty){
                  //   print('Success');

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

                    shrinkWrap: true,
                    itemCount: _todoListCubit.todoLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return noteInfo(_todoListCubit.todoLists[index].content, _todoListCubit.todoLists[index].time,_todoListCubit.todoLists[index].isTap);
                      // return NoteInfo(
                      //   todoList: _todoListCubit.todoLists[index],
                      // );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
                }
                //  return const SizedBox();
                //},
                ),
          ),
          // BlocBuilder<TodoListCubit, String>(
          //     bloc: _todoListCubit,
          //     builder: (ctx, state) {
          //       print(state);
          //       return Text(
          //         '${_todoListCubit.abc}',
          //         style: Theme.of(context).textTheme.headline4,
          //       );
          //     }),
          BlocListener<TodoListCubit, String>(
            bloc: _todoListCubit,
            listenWhen: (_, state) {
              print('Listening');
              return true;
            },
            listener: (_, state) {
              if (_todoListCubit.todoLists.isNotEmpty) {
                print('Corrected');
              }
            },
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget noteInfo(String content, String time, bool isTap){
    //Color colors = Colors.grey.shade400;
    return  BlocBuilder<TodoListCubit,String>(
      bloc: _todoListCubit,
      builder: (_,state){
        return GestureDetector(
          onTap: (){
            _todoListCubit.onTapItem(time);
            selItem =time;
            setState(() {
              
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: isTap?Colors.red:Colors.grey.shade400,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Content: $content')),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Time: $time')),
              ],
            ),
          ),
        );
      },
    );
  }

}

class NoteInfo extends StatelessWidget {
  final TodoList todoList;
  const NoteInfo({Key? key, required this.todoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Content: ${todoList.content}')),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Time: ${todoList.time}')),
          ],
        ),
      ),
    );
  }
}

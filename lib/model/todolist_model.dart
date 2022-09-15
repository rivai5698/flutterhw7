class TodoList{
    final String content;
    final String time;
    bool isTap;
    TodoList(this.content, this.time,this.isTap);

    @override
  String toString() {
    return 'TodoList{content: $content, time: $time, isTap: $isTap}';
  }
}
import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  const SubDetail({Key? key}) : super(key: key);

  @override
  _SubDetailState createState() => _SubDetailState();
}

class _SubDetailState extends State<SubDetail> {
  List<String> todoList = new List.empty(growable: true);
  //growable:true는 가변 길이라는 뜻

  @override
  void initState() {
    todoList.add('장 보기');
    todoList.add('약국 갔다오기');
    todoList.add('방청소하기');
    todoList.add('운동하기');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sub Detail'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                child: Text(
                  todoList[index],
                  style: TextStyle(fontSize: 30),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/third', arguments: todoList[index]);
                },
              ),
            );
          },
          itemCount: todoList.length,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addNavigation(context);
            },
            child: Icon(Icons.add)));
  }

  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second');
    setState(() {
      todoList.add(result as String);
    });
  }
}

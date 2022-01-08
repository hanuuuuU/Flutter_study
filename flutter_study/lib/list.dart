import 'package:flutter/material.dart';

class Lists extends StatefulWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  int count = 25;
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext build) {
        return ListView.separated(
          padding: EdgeInsets.all(10),
          controller: controller,
          itemCount: count,
          itemBuilder: (BuildContext ctx, int index) {
            return ListTile(
              title: Text('$index'),
              onTap: () {
                // ignore: deprecated_member_use
                Scaffold.of(build)
                    .showSnackBar(SnackBar(content: Text('hello')));
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: toTop,
        child: Icon(Icons.arrow_upward),
      ),
    );
  }

  void toTop() {
    final double start = 0;

    controller.animateTo(start,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  void toBottom() {
    final double end = controller.position.maxScrollExtent;

    controller.animateTo(end,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }
}

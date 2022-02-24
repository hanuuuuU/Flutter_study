import 'package:flutter/material.dart';

class SliversScreen extends StatefulWidget {
  const SliversScreen({Key? key}) : super(key: key);

  @override
  _SliversScreenState createState() => _SliversScreenState();
}

class _SliversScreenState extends State<SliversScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
			// ScrollView의 종류로 Sliver와 같이 사용된다.
      body: CustomScrollView(
        slivers: <Widget>[
					// appBar
          SliverAppBar(
            expandedHeight: 250.0,// appBar 높이
            pinned: true,
            floating: false,
            snap: false,
						// Sliver appBar를 설정
            flexibleSpace: FlexibleSpaceBar(
              title: Text('SliverAppBar'),
              centerTitle: true,
              background: FlutterLogo(),
            ),
          ),

					/*********************** body 부분 *************************/
					
					// Sliver 1
					// basic
          SliverFillRemaining(
            child: Center(child: Text("SliberAppBody")),
          ),

					// Sliver 2
					// Grid view
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,// Grid view 너비
              mainAxisSpacing: 10.0,// 행 간 거리
              crossAxisSpacing: 10.0,// 열 간 거리
            ),
						// 화면에 표시될 위젯을 설정
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: Text(
                    'Grid Item $index',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
              childCount: 10,
            ),
          ),

					// Sliver 3
					// List view
          SliverFixedExtentList(
            itemExtent: 50.0,
						// 화면에 표시될 위젯을 설정
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    'List Item $index',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
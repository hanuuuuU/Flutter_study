import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBuilderScreen extends StatefulWidget {
  const AnimatedBuilderScreen({Key? key}) : super(key: key);

  @override
  _AnimatedBuilderScreenState createState() => _AnimatedBuilderScreenState();
}

// TickerProviderStateMixin은 매 프레임마다 함수를 호출하는 객체인데
// 프레임이 변화되어야 할 때 알려주는 거라고 한다.
class _AnimatedBuilderScreenState extends State<AnimatedBuilderScreen>
    with TickerProviderStateMixin {


// 애니메이션을 설정한 Controller
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),// duration 동안 변화
    vsync: this,
  )..repeat();

// 앱이 종료되면 Controller로 종료시킨다.
@override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test AnimatedBuilder'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
            child: const Center(
              child: Text(
                'Whee!',
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * math.pi,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
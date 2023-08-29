import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 50,
      child: LoadingAnimationWidget.halfTriangleDot(
        size: 50,
        color: const Color(0xFF302E76),
      ),
    );
  }
}

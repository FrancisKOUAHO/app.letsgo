import 'package:LetsGo/widgets/not_available_yet.dart';
import 'package:flutter/cupertino.dart';

class VideoCameraScreen extends StatefulWidget {
  const VideoCameraScreen({Key? key}) : super(key: key);

  @override
  State<VideoCameraScreen> createState() => _VideoCameraScreenState();
}

class _VideoCameraScreenState extends State<VideoCameraScreen> {
  @override
  Widget build(BuildContext context) {
    return const NotAvailableYet();
  }
}
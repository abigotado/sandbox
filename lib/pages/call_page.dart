import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/widgets/video_call.dart';

class CallPage extends StatefulWidget {
  CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoCall(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Call"),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

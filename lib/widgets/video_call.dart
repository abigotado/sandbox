import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatefulWidget {
  VideoCall({Key? key}) : super(key: key);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  MediaStream? _mediaStream;
  final _videoRenderer = RTCVideoRenderer();
  bool _inCalling = false;

  initRenderers() async {
    await _videoRenderer.initialize();
  }

  _makeCall() async {
    final Map<String, dynamic> mediaConstraints = {
      "audio": true,
      "video": {
        "mandatory": {
          "minWidth": '480',
          "minHeight": '640',
          "minFrameRate": '25',
        },
        "facingMode": "user",
        "optional": [],
      }
    };

    try {
      navigator.mediaDevices.getUserMedia(mediaConstraints).then((stream) {
        _mediaStream = stream;
        _videoRenderer.srcObject = _mediaStream;
      });
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;

    setState(() {
      _inCalling = true;
    });
  }

  _hangUp() async {
    try {
      await _mediaStream!.dispose();
      _videoRenderer.srcObject = null;
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      _inCalling = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initRenderers();
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_inCalling) {
      _hangUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrientationBuilder(
          builder: (context, orientation) {
            return Center(
              child: Container(
                margin: EdgeInsets.all(0.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: RTCVideoView(_videoRenderer),
              ),
            );
          },
        ),
        Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                print('cam');
              },
              child: Icon(Icons.videocam_rounded),
            ),
            FloatingActionButton(
              onPressed: () {
                print('mic');
              },
              child: Icon(Icons.mic),
            ),
            FloatingActionButton(
              onPressed: _inCalling ? _hangUp : _makeCall,
              tooltip: _inCalling ? 'Hangup' : 'Call',
              child: Icon(_inCalling ? Icons.call_end_sharp : Icons.call_sharp),
            ),
          ],
        )
      ],
    );
  }
}

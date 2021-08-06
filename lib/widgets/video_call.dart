import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class VideoCall extends StatefulWidget {
  final String host;

  VideoCall({Key? key, required this.host}) : super(key: key);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  Signaling _signaling;
  List<dynamic> _peers;
  var _selfId;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  bool _inCalling = false;
  Session _session;

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  void _connect() async {
    if (_signaling == null) {
      _signaling = Signaling(widget.host)..connect();

      _signaling.onSignalingStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.ConnectionClosed:
          case SignalingState.ConnectionError:
          case SignalingState.ConnectionOpen:
            break;
        }
      };

      _signaling.onCallStateChange = (Session session, CallState state) {
        switch (state) {
          case CallState.CallStateNew:
            setState(() {
              _session = session;
              _inCalling = true;
            });
            break;
          case CallState.CallStateBye:
            setState(() {
              _localRenderer.srcObject = null;
              _remoteRenderer.srcObject = null;
              _inCalling = false;
              _session = null;
            });
            break;
          case CallState.CallStateInvite:
          case CallState.CallStateConnected:
          case CallState.CallStateRinging:
        }
      };
    }
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

  _hangUp() {
    if (_signaling != null) {
      _signaling.bye(_session.sid);
    }
  }

  @override
  void initState() {
    super.initState();
    initRenderers();
    _connect();
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_signaling != null) _signaling.close();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: OrientationBuilder(
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
        ),
        Container(
          margin: EdgeInsets.only(top: 500),
          padding: EdgeInsets.fromLTRB(30, 29, 30, 48),
          color: Colors.transparent,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: FloatingActionButton(
                    heroTag: '1',
                    onPressed: () {
                      print('cam');
                    },
                    child: Icon(Icons.videocam_rounded),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 35, right: 35),
                  child: FloatingActionButton(
                    heroTag: '2',
                    onPressed: () {
                      print('mic');
                    },
                    child: Icon(Icons.mic),
                  ),
                ),
                Container(
                  child: FloatingActionButton(
                    heroTag: '3',
                    onPressed: _inCalling ? _hangUp : _makeCall,
                    tooltip: _inCalling ? 'Hangup' : 'Call',
                    child: Icon(
                        _inCalling ? Icons.call_end_sharp : Icons.call_sharp),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sandbox/widgets/video_call.dart';

class CallPage extends StatefulWidget {
  CallPage({Key? key}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

enum DialogAction {
  cancel,
  connect,
}

class _CallPageState extends State<CallPage> {
  // List<RouteItem>? items;
  // String _server = '';
  // SharedPreferences? _prefs;
  //
  // bool _dataChannel = false;
  // @override
  // initState() {
  //   super.initState();
  //   _initData();
  //   _initItems();
  // }
  //
  // _buildRow(context, item) {
  //   return ListBody(children: <Widget>[
  //     ListTile(
  //       title: Text(item.title),
  //       onTap: () => item.push(context),
  //       trailing: Icon(Icons.arrow_right),
  //     ),
  //     Divider()
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoCall(),
    );
  }

  // _initData() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _server = _prefs!.getString('server') ??
  //         'wss://flutter-sandbox-abigotado.herokuapp.com';
  //   });
  // }
  //
  // void showDemoDialog<T>({BuildContext? context, Widget? child}) {
  //   showDialog<T>(
  //     context: context!,
  //     builder: (BuildContext context) => child!,
  //   ).then<void>((T? value) {
  //     if (value != null) {
  //       if (value == DialogAction.connect) {
  //         _prefs!.setString('server', _server);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (BuildContext context) => _dataChannel
  //                     ? DataChannel(host: _server)
  //                     : VideoCall(host: _server)));
  //       }
  //     }
  //   });
  // }
  //
  // _showAddressDialog(context) {
  //   showDemoDialog<DialogAction>(
  //       context: context,
  //       child: AlertDialog(
  //           title: const Text('Enter server address:'),
  //           content: TextField(
  //             onChanged: (String text) {
  //               setState(() {
  //                 _server = text;
  //               });
  //             },
  //             decoration: InputDecoration(
  //               hintText: _server,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //                 child: const Text('CANCEL'),
  //                 onPressed: () {
  //                   Navigator.pop(context, DialogAction.cancel);
  //                 }),
  //             TextButton(
  //                 child: const Text('CONNECT'),
  //                 onPressed: () {
  //                   Navigator.pop(context, DialogAction.connect);
  //                 })
  //           ]));
  // }
  //
  // _initItems() {
  //   items = <RouteItem>[
  //     RouteItem(
  //         title: 'P2P Call Sample',
  //         subtitle: 'P2P Call Sample.',
  //         push: (BuildContext context) {
  //           MaterialPageRoute(builder: (BuildContext context) => VideoCall());
  //         }),
  //     RouteItem(
  //         title: 'Data Channel Sample',
  //         subtitle: 'P2P Data Channel.',
  //         push: (BuildContext context) {
  //           _dataChannel = true;
  //           _showAddressDialog(context);
  //         }),
  //   ];
  // }
}

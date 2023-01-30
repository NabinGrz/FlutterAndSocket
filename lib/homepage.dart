import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketIO;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late socketIO.Socket socket;

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    socket = socketIO.io("http://10.0.2.2:65432", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    call();
    super.initState();
  }

  call() async {
    await initSocket();
  }

  Future<void> initSocket() async {
    try {
      print("Nabin gurung1");

      print("Nabin gurun2");
      //Connecting Socket
      socket.connect();

      //After Connected
      socket.onConnect((_) => print("vehicle-tracking: ${socket.id}"));
      socket.onError(
        (data) {
          print("Socket Error $data");
        },
      );
      print("Nabin gurun3");
    } on Exception catch (e) {
      log("Socket Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 29,
              width: 29,
              color: Colors.red,
              child: Text("${socket.ids}"),
            ),
            ElevatedButton(
                onPressed: () async {
                  //Sending Data to Socket Server
                  socket.emit("event", jsonEncode("object"));
                },
                child: const Text("Send To Socket Server!!"))
          ],
        ),
      ),
    );
  }
}

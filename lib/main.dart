// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print("trying to connect");
    Socket socket = io(
        'ws://10.0.2.2:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

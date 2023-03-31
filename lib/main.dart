import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servo Control App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Servo Control App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _statusText = 'Servo is currently off';

  void _turnOnServo() async {
    final response = await http.get(Uri.parse('http://192.168.1.100/servo/on')); // replace with the IP address of your NodeMCU board
    if (response.statusCode == 200) {
      setState(() {
        _statusText = 'Servo turned on';
      });
    } else {
      setState(() {
        _statusText = 'Error turning on servo';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _turnOnServo,
              child: Text('Turn on servo'),
            ),
            SizedBox(height: 20),
            Text(_statusText),
          ],
        ),
      ),
    );
  }
}

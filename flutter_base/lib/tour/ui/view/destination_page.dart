import 'package:flutter/material.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({super.key, required this.destination});

  static const routeName = 'destination';

  final Map<String, dynamic> destination;

  @override
  State<DestinationPage> createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination['title']!),
        centerTitle: true,
      ),
      body: Center(child: Text('Destination Page')),
    );
  }
}

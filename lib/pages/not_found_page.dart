import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  final RouteSettings settings;

  const NotFoundPage({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404'),
      ),
      body: Center(
        child: Text('route path ${settings.name} not found'),
      ),
    );
  }
}

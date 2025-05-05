import 'package:flutter/material.dart';

class BlockedScreen extends StatelessWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blocked User'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('No blocked user here'),
      ),
    );
  }
}

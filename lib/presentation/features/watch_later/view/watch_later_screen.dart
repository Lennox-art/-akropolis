import 'package:flutter/material.dart';

class WatchLaterScreen extends StatelessWidget {
  const WatchLaterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch Later'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('You do not have post to watch later'),
      ),
    );
  }
}

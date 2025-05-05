import 'package:flutter/material.dart';

class BookmarkedScreen extends StatelessWidget {
  const BookmarkedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked'),
      ),
      body: Center(
        child: Text('You do not have bookmark yet'),
      ),
    );
  }
}

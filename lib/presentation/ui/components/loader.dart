import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:network_service/network_service.dart';

class InfiniteLoader extends StatelessWidget {
  const InfiniteLoader({this.size = 50, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      /*child: LoadingAnimationWidget.staggeredDotsWave(
        color: primaryColor,
        size: size,
      ),*/
      child: Text("..."),
    );
  }
}

class FiniteLoader extends StatelessWidget {
  const FiniteLoader({
    required this.progress,
    super.key,
  });

  final ProgressModel progress;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress.percent / 100,
      backgroundColor: Colors.grey,
      color: primaryColor,
    );
  }
}


class CircularFiniteLoader extends StatelessWidget {
  const CircularFiniteLoader({
    required this.progress,
    super.key,
  });

  final ProgressModel progress;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: progress.percent / 100,
      backgroundColor: Colors.grey,
      color: primaryColor,
    );
  }
}

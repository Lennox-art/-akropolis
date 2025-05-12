import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/presentation/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class InfiniteLoader extends StatelessWidget {
  const InfiniteLoader({this.size = 50, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: primaryColor,
        size: size,
      ),
    );
  }
}

class FiniteLoader extends StatelessWidget {
  const FiniteLoader({
    required this.progress,
    this.width = 50,
    super.key,
  });

  final ProgressModel progress;
  final double width;
  double get percent => progress.percent / 100;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 4.0,
      percent: percent,
      padding: EdgeInsets.zero,
      restartAnimation: true,
      animation: true,
      backgroundColor: Colors.grey,
      animateFromLastPercent: true,
      animateToInitialPercent: true,
      progressColor: primaryColor,
      center: Text('${progress.percent.toStringAsFixed(0)} %'),
    );
  }
}

class CircularFiniteLoader extends StatelessWidget {
  const CircularFiniteLoader({
    required this.progress,
    this.radius = 40,
    super.key,
  });

  final ProgressModel progress;
  final double radius;

  double get percent => progress.percent / 100;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircularPercentIndicator(
        radius: radius,
        lineWidth: radius / 6,
        percent: percent,
        animateFromLastPercent: true,
        animateToInitialPercent: true,
        animation: true,
        animationDuration: 200,
        center: Text('${progress.percent.toStringAsFixed(0)} %'),
        progressColor: primaryColor,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

import 'dart:core';

import 'package:akropolis/presentation/ui/themes.dart';
import 'package:akropolis/data/utils/duration_style.dart';
import 'package:flutter/material.dart';

class DurationPickerBottomSheet extends StatelessWidget {
  DurationPickerBottomSheet({
    this.divisions = 8,
    required this.onConfirm,
    required this.maxDuration,
    required this.minDuration,
    super.key,
  });

  final int divisions;
  final Duration maxDuration;
  final Duration minDuration;
  final Function(Duration) onConfirm;
  late final ValueNotifier<Duration> durationNotifier = ValueNotifier(minDuration);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        "Set Timer",
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    onPressed: Navigator.of(context).pop,
                  ),
                ],
              ),
              Text(
                "Set the length of the timer before recording",
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    minDuration.format(DurationStyle.FORMAT_MM_SS),
                  ),
                  Text(
                    maxDuration.format(DurationStyle.FORMAT_MM_SS),
                  ),
                ],
              ),
              SizedBox(
                height: 120,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    DurationBackground(
                      divisions: divisions,
                    ),
                    ValueListenableBuilder(
                      valueListenable: durationNotifier,
                      builder: (_, duration, __) {
                        return SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            // overlayShape: SliderComponentShape.noOverlay,
                            activeTrackColor: primaryColor.withValues(alpha: 0.5),
                            trackHeight: 40,
                            inactiveTrackColor: Colors.transparent,
                          ),
                          child: Slider(
                            label: duration.format(DurationStyle.FORMAT_MM_SS),
                            min: Duration.zero.inSeconds.toDouble(),
                            max: maxDuration.inSeconds.toDouble(),
                            value: duration.inSeconds.toDouble(),
                            onChanged: (newDuration) {
                              durationNotifier.value = Duration(seconds: newDuration.round());
                            },
                            divisions: divisions,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => onConfirm(durationNotifier.value),
                child: const Text("Set Timer"),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<Duration?> showDurationPickerDialog(
  BuildContext context, {
  required Duration maxDuration,
  Duration minDuration = Duration.zero,
}) {
  return showModalBottomSheet<Duration?>(
    context: context,
    builder: (c) => DurationPickerBottomSheet(
      onConfirm: (d) {
        Navigator.of(context).pop(d);
      },
      maxDuration: maxDuration,
      minDuration: minDuration,
    ),
  );
}

class DurationBackground extends StatelessWidget {
  const DurationBackground({required this.divisions,super.key});

  final int divisions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Flex(
        direction: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          divisions,
          (i) {
            bool isEven = i % 2 == 0;
            double height = 35;
            return Flexible(
              child: Container(
                width: 5,
                height: isEven ? height : height / 2,
                decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            );
          },
        ),
      ),
    );
  }
}

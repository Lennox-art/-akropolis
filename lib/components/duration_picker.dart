import 'dart:core';

import 'package:akropolis/utils/duration_style.dart';
import 'package:flutter/material.dart';

class DurationPickerBottomSheet extends StatelessWidget {
  DurationPickerBottomSheet({
    this.divisions = 10,
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
              ValueListenableBuilder(
                valueListenable: durationNotifier,
                builder: (_, duration, __) {
                  return Slider(
                    
                    label: duration.format(DurationStyle.FORMAT_MM_SS),
                    min: Duration.zero.inSeconds.toDouble(),
                    max: maxDuration.inSeconds.toDouble(),
                    value: duration.inSeconds.toDouble(),
                    onChanged: (newDuration) {
                      durationNotifier.value = Duration(seconds: newDuration.round());
                    },
                    divisions: divisions,
                  );
                },
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

import 'dart:async';
import 'dart:math';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_media_view.freezed.dart';

@freezed
class CameraSettings with _$CameraSettings {
  const factory CameraSettings.create({
    @Default(0.0) double minExposureOffset,
    @Default(0.0) double maxExposureOffset,
    @Default(0.0) double currentExposureOffset,
    @Default(1.0) double minZoom,
    @Default(1.0) double maxZoom,
    @Default(1.0) double currentZoom,
    @Default(1.0) double baseScale,
    @Default(1.0) double currentScale,
    @Default(0) int pointersOnScreen,
    Offset? exposurePoint,
    Offset? focusPoint,
    @Default(true) bool enableAudio,
    @Default(FlashMode.auto) FlashMode flashMode,
    Duration? recordDuration,
    @Default(false) bool isRecording,
    XFile? cameraFile,
  }) = DefaultCameraSettings;
}

/// Camera example home widget.
class CameraMediaView extends StatefulWidget {
  const CameraMediaView({super.key});

  @override
  State<CameraMediaView> createState() => _CameraMediaViewState();
}

class _CameraMediaViewState extends State<CameraMediaView> with WidgetsBindingObserver, TickerProviderStateMixin {
  VideoPlayerController? videoController;
  CameraController? cameraController;
  Timer? recordTimer;

  final ValueNotifier<CameraSettings> settingsNotifier = ValueNotifier(
    const DefaultCameraSettings(),
  );

  Future<void> startRecording(CameraController cameraController) async {
    if (settingsNotifier.value.isRecording) return;

    //Prepare recording
    await cameraController.prepareForVideoRecording();

    //Prepare stopwatch
    final Stopwatch stopwatch = Stopwatch();

    //Start video recording
    await cameraController.startVideoRecording();

    //Start stopwatch
    stopwatch.start();

    //Every second ...
    recordTimer = Timer.periodic(
      const Duration(seconds: 2),
      (t) async {
        //If recording, update settings
        CameraSettings camSettings = settingsNotifier.value;
        if (camSettings.isRecording) {
          log.info("Recoding in progress ${stopwatch.elapsed.inMinutes} : ${stopwatch.elapsed.inSeconds}");
          settingsNotifier.value = camSettings.copyWith(
            recordDuration: stopwatch.elapsed,
            isRecording: true,
          );
          return;
        }

      },
    );

    settingsNotifier.addListener(
      () async {
        CameraSettings camSettings = settingsNotifier.value;
        if(camSettings.isRecording) return;

        log.info("Recoding stopped at ${stopwatch.elapsed.inMinutes} : ${stopwatch.elapsed.inSeconds}");

        //If recording stopped
        XFile data = await cameraController.stopVideoRecording();
        settingsNotifier.value = camSettings.copyWith(
          cameraFile: data,
          isRecording: false,
        );

        stopwatch.stop();
        recordTimer?.cancel();
        cancelTimer();
      },
    );

    log.info("Camera is recording");
  }

  void cancelTimer() {
    if (recordTimer?.isActive ?? false) {
      recordTimer?.cancel();
      recordTimer = null;
    }
  }

  Future<void> initializeCameraController({
    required CameraController cameraController,
  }) async {
    try {
      await cameraController.initialize();

      this.cameraController = cameraController;

      double minAvailableZoom = await cameraController.getMinZoomLevel();
      double maxAvailableZoom = await cameraController.getMaxZoomLevel();
      double maxExposureOffset = await cameraController.getMaxExposureOffset();
      double minExposureOffset = await cameraController.getMinExposureOffset();
      cameraController.lockCaptureOrientation(DeviceOrientation.landscapeRight);

      settingsNotifier.value = settingsNotifier.value.copyWith(
        minZoom: minAvailableZoom,
        maxZoom: maxAvailableZoom,
        maxExposureOffset: maxExposureOffset,
        minExposureOffset: minExposureOffset,
      );
    } on CameraException catch (e, trace) {
      _showCameraException(e, trace);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log.info("Camera lifecycle changed to $state");

    final CameraController? cameraController = this.cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
        cameraController.dispose();
        break;
      case AppLifecycleState.resumed:
        cameraController.resumeVideoRecording();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        cameraController.stopVideoRecording();
        break;
      case AppLifecycleState.paused:
        cameraController.pauseVideoRecording();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        actions: [
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.cancel_outlined,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: availableCameras(),
        builder: (_, camerasSnap) {
          if (camerasSnap.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator.adaptive();
          }

          if (camerasSnap.hasError) {
            SchedulerBinding.instance.addPostFrameCallback((_) async {
              ToastError(
                title: "Cameras",
                message: camerasSnap.error.toString(),
              ).show();
            });
          }

          final List<CameraDescription> cameras = camerasSnap.data ?? [];

          if (cameras.isEmpty) {
            SchedulerBinding.instance.addPostFrameCallback((_) async {
              ToastInfo(
                title: "No camera found",
                message: camerasSnap.error.toString(),
              ).show();
            });
            return const Text('None');
          }

          final ValueNotifier<CameraDescription> cameraNotifier = ValueNotifier(
            cameras.first,
          );

          return ValueListenableBuilder(
            valueListenable: cameraNotifier,
            builder: (_, camera, __) {
              final CameraController cameraController = CameraController(
                camera,
                ResolutionPreset.max,
                enableAudio: settingsNotifier.value.enableAudio,
                imageFormatGroup: ImageFormatGroup.jpeg,
              );

              return FutureBuilder(
                future: initializeCameraController(
                  cameraController: cameraController,
                ),
                builder: (_, ccSnap) {
                  if (ccSnap.connectionState != ConnectionState.done) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  if (ccSnap.hasError) {
                    SchedulerBinding.instance.addPostFrameCallback((_) async {
                      ToastError(
                        title: "Initialization",
                        message: ccSnap.error.toString(),
                      ).show();
                    });
                  }

                  settingsNotifier.addListener(
                    () {
                      try {
                        var settings = settingsNotifier.value;
                        cameraController.setExposureOffset(
                          settings.currentExposureOffset,
                        );

                        cameraController.setZoomLevel(
                          settings.currentZoom,
                        );

                        cameraController.setFlashMode(
                          settings.flashMode,
                        );

                        cameraController.setExposurePoint(
                          settings.exposurePoint,
                        );

                        cameraController.setFocusPoint(
                          settings.focusPoint,
                        );
                      } on CameraException catch (e) {
                        _showCameraException(e);
                        rethrow;
                      }
                    },
                  );

                  return ValueListenableBuilder(
                    valueListenable: settingsNotifier,
                    builder: (_, camSettings, __) {
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Listener(
                            onPointerDown: (_) {
                              settingsNotifier.value = camSettings.copyWith(
                                pointersOnScreen: camSettings.pointersOnScreen + 1,
                              );
                            },
                            onPointerUp: (_) {
                              settingsNotifier.value = camSettings.copyWith(
                                pointersOnScreen: camSettings.pointersOnScreen - 1,
                              );
                            },
                            child: CameraPreview(
                              cameraController,
                              child: LayoutBuilder(
                                builder: (_, constraints) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onScaleStart: (d) {},
                                    onScaleUpdate: (d) async {
                                      if (d.pointerCount != 2) return;

                                      double zoomLevel = (camSettings.baseScale * d.scale).clamp(
                                        camSettings.minZoom,
                                        camSettings.maxZoom,
                                      );

                                      settingsNotifier.value = camSettings.copyWith(
                                        currentScale: zoomLevel,
                                      );

                                      await cameraController.setZoomLevel(zoomLevel);
                                    },
                                    onTapDown: (details) {
                                      final Offset offset = Offset(
                                        details.localPosition.dx / constraints.maxWidth,
                                        details.localPosition.dy / constraints.maxHeight,
                                      );

                                      settingsNotifier.value = camSettings.copyWith(
                                        exposurePoint: offset,
                                        focusPoint: offset,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () async {
                                  if (!settingsNotifier.value.isRecording) {
                                    startRecording(cameraController);
                                    return;
                                  }

                                  settingsNotifier.value = camSettings.copyWith(
                                    isRecording: false,
                                  );
                                },
                                child: ShutterButton(
                                  duration: camSettings.isRecording ? camSettings.recordDuration : null,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    switch (camera.lensDirection) {
                                      CameraLensDirection.front => IconButton(
                                          onPressed: () {
                                            CameraDescription? backCamera =
                                                cameras.where((c) => c.lensDirection == CameraLensDirection.back).firstOrNull;

                                            if (backCamera == null) {
                                              const ToastInfo(
                                                title: "Camera flip",
                                                message: "No rear camera",
                                              ).show();
                                              return;
                                            }

                                            cameraNotifier.value = backCamera;
                                          },
                                          icon: const Icon(Icons.camera_rear_outlined),
                                        ),
                                      CameraLensDirection.back => IconButton(
                                          onPressed: () {
                                            CameraDescription? frontCamera =
                                                cameras.where((c) => c.lensDirection == CameraLensDirection.front).firstOrNull;

                                            if (frontCamera == null) {
                                              const ToastInfo(
                                                title: "Camera flip",
                                                message: "No front camera",
                                              ).show();
                                              return;
                                            }

                                            cameraNotifier.value = frontCamera;
                                          },
                                          icon: const Icon(Icons.camera_front_outlined),
                                        ),
                                      _ => const SizedBox.shrink(),
                                    },
                                    switch (camSettings.flashMode) {
                                      FlashMode.off => IconButton(
                                          onPressed: () {
                                            settingsNotifier.value = camSettings.copyWith(
                                              flashMode: FlashMode.auto,
                                            );
                                          },
                                          icon: const Icon(Icons.flash_auto_outlined),
                                        ),
                                      FlashMode.auto => IconButton(
                                          onPressed: () {
                                            settingsNotifier.value = camSettings.copyWith(
                                              flashMode: FlashMode.always,
                                            );
                                          },
                                          icon: const Icon(Icons.flash_on_outlined),
                                        ),
                                      FlashMode.always => IconButton(
                                          onPressed: () {
                                            settingsNotifier.value = camSettings.copyWith(
                                              flashMode: FlashMode.torch,
                                            );
                                          },
                                          icon: const Icon(Icons.flashlight_on_outlined),
                                        ),
                                      FlashMode.torch => IconButton(
                                          onPressed: () {
                                            settingsNotifier.value = camSettings.copyWith(
                                              flashMode: FlashMode.auto,
                                            );
                                          },
                                          icon: const Icon(Icons.flash_off_outlined),
                                        ),
                                    },
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String get timestamp => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> onTakePictureButtonPressed(CameraController cameraController) async {
    XFile? pic = await takePicture(cameraController);
    settingsNotifier.value = settingsNotifier.value.copyWith(
      cameraFile: pic,
    );
    videoController?.dispose();
    videoController = null;
  }

  Future<void> onCaptureOrientationLockButtonPressed(CameraController cameraController) async {
    try {
      if (cameraController.value.isCaptureOrientationLocked) {
        await cameraController.unlockCaptureOrientation();
        const ToastInfo(
          title: "Capture orientation",
          message: 'Capture orientation unlocked',
        ).show();
      } else {
        await cameraController.lockCaptureOrientation();
        ToastInfo(
          title: "Capture orientation",
          message: 'Capture orientation locked to ${cameraController.value.lockedCaptureOrientation.toString().split('.').last}',
        ).show();
      }
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  Future<XFile?> takePicture(CameraController cameraController) async {
    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e, trace) {
      _showCameraException(e, trace);
      return null;
    }
  }

  void _showCameraException(CameraException e, [StackTrace? trace]) {
    log.error(e.description, trace: trace);
    String message = switch (e.code) {
      'CameraAccessDenied' => 'You have denied camera access.',
      'CameraAccessDeniedWithoutPrompt' => 'Please go to Settings to enable camera access.',
      'CameraAccessRestricted' => 'Camera access is restricted.',
      'AudioAccessDenied' => 'You have denied audio access.',
      'AudioAccessDeniedWithoutPrompt' => 'Please go to Settings to enable audio access.',
      'AudioAccessRestricted' => 'Audio access is restricted.',
      _ => 'Error: ${e.code}\n${e.description}'
    };
    ToastError(
      title: e.code,
      message: message,
    ).show();
  }
}

class MakeCircle extends CustomPainter {
  final double strokeWidth;
  final StrokeCap strokeCap;

  MakeCircle({this.strokeCap = StrokeCap.square, this.strokeWidth = 10.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke; //important set stroke style

    final path = Path()
      ..moveTo(strokeWidth, strokeWidth)
      ..arcToPoint(Offset(size.width - strokeWidth, size.height - strokeWidth), radius: Radius.circular(max(size.width, size.height)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ShutterButton extends StatelessWidget {
  const ShutterButton({this.duration, super.key});

  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: duration != null,
      replacement: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle_outlined,
            color: Colors.white70,
            size: 100,
          ),
          Icon(
            Icons.circle_outlined,
            color: Colors.red,
            size: 70,
          ),
        ],
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle_outlined,
            color: Colors.white70,
            size: 100,
          ),
          Icon(
            Icons.cancel,
            color: Colors.black,
            size: 70,
          ),
        ],
      ),
    );
  }
}

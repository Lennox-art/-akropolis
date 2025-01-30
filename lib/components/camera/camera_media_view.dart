import 'package:akropolis/main.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
    CameraLensDirection? lensDirection,
    @Default(FlashMode.auto) FlashMode flashMode,
    XFile? cameraFile,
  }) = DefaultCameraSettings;
}

/// Camera example home widget.
class CameraMediaView extends StatefulWidget {
  const CameraMediaView({super.key});

  @override
  State<CameraMediaView> createState() => _CameraMediaViewState();
}

/// Returns a suitable camera icon for [direction].
IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  // This enum is from a different package, so a new value could be added at
  // any time. The example should keep working if that happens.
  // ignore: dead_code
  return Icons.camera;
}

class _CameraMediaViewState extends State<CameraMediaView> with WidgetsBindingObserver, TickerProviderStateMixin {
  VideoPlayerController? videoController;

  late final AnimationController _flashModeControlRowAnimationController;
  late final CurvedAnimation _flashModeControlRowAnimation;
  late final AnimationController _exposureModeControlRowAnimationController;
  late final CurvedAnimation _exposureModeControlRowAnimation;
  late final AnimationController _focusModeControlRowAnimationController;
  late final CurvedAnimation _focusModeControlRowAnimation;

  final ValueNotifier<CameraSettings> settingsNotifier = ValueNotifier(
    const DefaultCameraSettings(),
  );

  Future<void> initializeCameraController({
    required CameraController cameraController,
  }) async {
    try {
      await cameraController.initialize();

      double minAvailableZoom = await cameraController.getMinZoomLevel();
      double maxAvailableZoom = await cameraController.getMaxZoomLevel();
      double maxExposureOffset = await cameraController.getMaxExposureOffset();
      double minExposureOffset = await cameraController.getMinExposureOffset();

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

    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _flashModeControlRowAnimation = CurvedAnimation(
      parent: _flashModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    _exposureModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _exposureModeControlRowAnimation = CurvedAnimation(
      parent: _exposureModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    _focusModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _focusModeControlRowAnimation = CurvedAnimation(
      parent: _focusModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _flashModeControlRowAnimationController.dispose();
    _flashModeControlRowAnimation.dispose();
    _exposureModeControlRowAnimationController.dispose();
    _exposureModeControlRowAnimation.dispose();
    _focusModeControlRowAnimationController.dispose();
    _focusModeControlRowAnimation.dispose();
    super.dispose();
  }

  /*
  TODO:// Handle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log.info("Camera lifecycle changed to $state");

    final CameraController? cameraController = cController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCameraController(cameraController.description);
    }
  }*/

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
              showInSnackBar(camerasSnap.error.toString());
            });
          }

          final List<CameraDescription> cameras = camerasSnap.data ?? [];

          if (cameras.isEmpty) {
            SchedulerBinding.instance.addPostFrameCallback((_) async {
              showInSnackBar('No camera found.');
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
                ResolutionPreset.medium,
                enableAudio: true,
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
                      showInSnackBar(ccSnap.error.toString());
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
                                onTap: () => onTakePictureButtonPressed(cameraController),
                                child: const CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.white12,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.red,
                                  ),
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
                                  physics: ClampingScrollPhysics(),
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.flip_camera_ios_outlined),
                                    ), IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.flash_auto),
                                    ), IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.camera),
                                    ), IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.camera),
                                    ),
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

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> onTakePictureButtonPressed(CameraController cameraController) async {
    XFile? pic = await takePicture(cameraController);
    settingsNotifier.value = settingsNotifier.value.copyWith(
      cameraFile: pic,
    );
    videoController?.dispose();
    videoController = null;
  }

  void onFlashModeButtonPressed() {
    if (_flashModeControlRowAnimationController.value == 1) {
      _flashModeControlRowAnimationController.reverse();
    } else {
      _flashModeControlRowAnimationController.forward();
      _exposureModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onExposureModeButtonPressed() {
    if (_exposureModeControlRowAnimationController.value == 1) {
      _exposureModeControlRowAnimationController.reverse();
    } else {
      _exposureModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onFocusModeButtonPressed() {
    if (_focusModeControlRowAnimationController.value == 1) {
      _focusModeControlRowAnimationController.reverse();
    } else {
      _focusModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
      _exposureModeControlRowAnimationController.reverse();
    }
  }

  void toggleAudio() => settingsNotifier.value = settingsNotifier.value.copyWith(
        enableAudio: !settingsNotifier.value.enableAudio,
      );

  Future<void> onCaptureOrientationLockButtonPressed(CameraController cameraController) async {
    try {
      if (cameraController.value.isCaptureOrientationLocked) {
        await cameraController.unlockCaptureOrientation();
        showInSnackBar('Capture orientation unlocked');
      } else {
        await cameraController.lockCaptureOrientation();
        showInSnackBar('Capture orientation locked to ${cameraController.value.lockedCaptureOrientation.toString().split('.').last}');
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
    showInSnackBar(message);
  }
}

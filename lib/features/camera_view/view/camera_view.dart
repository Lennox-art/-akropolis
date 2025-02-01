import 'dart:io';
import 'dart:typed_data';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/camera_view/models/camera_models.dart';
import 'package:akropolis/features/camera_view/view_model/camera_cubit.dart';
import 'package:akropolis/main.dart';
import 'package:akropolis/theme/themes.dart';
import 'package:akropolis/utils/functions.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

/// Camera example home widget.
class CameraMediaView extends StatefulWidget {
  const CameraMediaView({super.key});

  @override
  State<CameraMediaView> createState() => _CameraMediaViewState();
}

class _CameraMediaViewState extends State<CameraMediaView> with WidgetsBindingObserver, TickerProviderStateMixin {
  late final CameraCubit cameraCubit = BlocProvider.of<CameraCubit>(context);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    cameraCubit.initializeCamera().then((cameras) {
      if (cameras.isEmpty) return;
      cameraCubit.chooseCamera(
        camera: cameras.first,
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraCubit.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log.info("Camera lifecycle changed to $state");

    switch (state) {
      case AppLifecycleState.resumed:
        cameraCubit.resumeRecording();
        break;
      case AppLifecycleState.paused:
        cameraCubit.pauseRecording();
        break;
      default:
        cameraCubit.dispose();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: null,
        actions: [
          IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.cancel_outlined,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocConsumer<CameraCubit, CameraState>(
        listener: (context, state) {
          state.map(
            loading: (s) {
              s.toast?.show();
            },
            uninitialized: (s) {
              s.toast?.show();
            },
            initialized: (s) {
              s.toast?.show();
            },
            preview: (s) {
              s.toast?.show();
            },
            recording: (s) {
              s.toast?.show();
            },
          );
        },
        builder: (context, state) {
          return state.map(
            loading: (a) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            uninitialized: (s) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initialize camera",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),
                  IconButton(
                    onPressed: cameraCubit.initializeCamera,
                    icon: const Icon(
                      Icons.play_circle,
                      size: 200,
                    ),
                  ),
                  Visibility(
                    visible: s.toast != null,
                    child: Text(
                      s.toast?.message ?? '',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: errorColor,
                      ),
                    ),
                  ),
                ],
              );
            },
            initialized: (i) {
              Map<CameraLensDirection, CameraDescription> cameraMap = {};

              for (var d in i.deviceCameras) {
                cameraMap.putIfAbsent(d.lensDirection, () => d);
              }
              List<CameraDescription> deviceCameras = cameraMap.values.toList();

              return Visibility(
                visible: deviceCameras.isNotEmpty,
                replacement: Text(
                  i.toast?.message ?? "Device has no cameras",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: errorColor,
                  ),
                ),
                child: ListView(
                  children: [
                    Text(
                      "Choose a camera",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                    ...deviceCameras.map(
                      (c) => ListTile(
                        onTap: () {
                          cameraCubit.chooseCamera(
                            camera: c,
                          );
                        },
                        title: Text(c.lensDirection.title),
                        leading: Icon(c.lensDirection.iconData),
                      ),
                    )
                  ],
                ),
              );
            },
            preview: (p) {
              CameraSettings cameraSettings = p.camSettings;
              CameraDescription camera = p.camera;
              List<CameraDescription> deviceCameras = p.deviceCameras;
              CameraController cameraController = p.cameraController;
              return Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Listener(
                          onPointerDown: (_) {
                            cameraCubit.modifyCameraSettings(
                              cameraSettings: cameraSettings.copyWith(
                                pointersOnScreen: cameraSettings.pointersOnScreen + 1,
                              ),
                            );
                          },
                          onPointerUp: (_) {
                            cameraCubit.modifyCameraSettings(
                              cameraSettings: cameraSettings.copyWith(
                                pointersOnScreen: cameraSettings.pointersOnScreen - 1,
                              ),
                            );
                          },
                          child: LayoutBuilder(
                            builder: (_, constraints) {
                              return SizedBox(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                child: CameraPreview(
                                  cameraController,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onScaleStart: (d) {},
                                    onScaleUpdate: (d) async {
                                      if (d.pointerCount != 2) return;

                                      double zoomLevel = (cameraSettings.baseScale * d.scale).clamp(
                                        cameraSettings.minZoom,
                                        cameraSettings.maxZoom,
                                      );

                                      cameraCubit.modifyCameraSettings(
                                        cameraSettings: cameraSettings.copyWith(
                                          currentZoom: zoomLevel,
                                        ),
                                      );
                                    },
                                    onTapDown: (details) {
                                      final Offset offset = Offset(
                                        details.localPosition.dx / constraints.maxWidth,
                                        details.localPosition.dy / constraints.maxHeight,
                                      );

                                      cameraCubit.modifyCameraSettings(
                                        cameraSettings: cameraSettings.copyWith(
                                          exposurePoint: offset,
                                          focusPoint: offset,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () async {
                                cameraCubit.startRecording(
                                  camera: camera,
                                  cameraController: cameraController,
                                );
                              },
                              child: const Stack(
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
                                              deviceCameras.where((c) => c.lensDirection == CameraLensDirection.back).firstOrNull;

                                          if (backCamera == null) {
                                            const ToastInfo(
                                              title: "Camera flip",
                                              message: "No rear camera",
                                            ).show();
                                            return;
                                          }
                                          cameraCubit.chooseCamera(
                                            camera: backCamera,
                                          );
                                        },
                                        icon: Icon(camera.lensDirection.iconData),
                                      ),
                                    CameraLensDirection.back => IconButton(
                                        onPressed: () {
                                          CameraDescription? frontCamera =
                                              deviceCameras.where((c) => c.lensDirection == CameraLensDirection.front).firstOrNull;

                                          if (frontCamera == null) {
                                            const ToastInfo(
                                              title: "Camera flip",
                                              message: "No front camera",
                                            ).show();
                                            return;
                                          }

                                          cameraCubit.chooseCamera(camera: frontCamera);
                                        },
                                        icon: Icon(camera.lensDirection.iconData),
                                      ),
                                    _ => const SizedBox.shrink(),
                                  },
                                  switch (cameraSettings.flashMode) {
                                    FlashMode.off => IconButton(
                                        onPressed: () {
                                          cameraCubit.modifyCameraSettings(
                                            cameraSettings: cameraSettings.copyWith(
                                              flashMode: FlashMode.auto,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.flash_off_outlined),
                                      ),
                                    FlashMode.auto => IconButton(
                                        onPressed: () {
                                          cameraCubit.modifyCameraSettings(
                                            cameraSettings: cameraSettings.copyWith(
                                              flashMode: FlashMode.always,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.flash_auto_outlined),
                                      ),
                                    FlashMode.always => IconButton(
                                        onPressed: () {
                                          cameraCubit.modifyCameraSettings(
                                            cameraSettings: cameraSettings.copyWith(
                                              flashMode: FlashMode.torch,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.flash_on_outlined),
                                      ),
                                    FlashMode.torch => IconButton(
                                        onPressed: () {
                                          cameraCubit.modifyCameraSettings(
                                            cameraSettings: cameraSettings.copyWith(
                                              flashMode: FlashMode.auto,
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.flashlight_on_outlined),
                                      ),
                                  },
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: cameraSettings.cameraFile != null,
                    child: Builder(
                      builder: (context) {
                        XFile? file = cameraSettings.cameraFile;
                        if (file == null) return const SizedBox.shrink();

                        double size = 100;

                        return FutureBuilder(
                          future: generateThumbnailBytes(videoPath: file.path),
                          builder: (_, snap) {
                            if (snap.connectionState != ConnectionState.done) {
                              return const CircularProgressIndicator.adaptive();
                            }

                            if (snap.hasError) {
                              return const Icon(Icons.broken_image_outlined);
                            }

                            Uint8List? imageBytes = snap.data;

                            if (imageBytes == null || imageBytes.isEmpty) {
                              return const Icon(Icons.hide_image_outlined);
                            }

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: size,
                                  width: size,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.pink),
                                  ),
                                  child: Center(
                                    child: Image.memory(
                                      fit: BoxFit.fill,
                                      height: size,
                                      width: size,
                                      imageBytes,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final Directory tempDir = await getTemporaryDirectory();
                                      final String tempVideoPath = '${tempDir.path}/${file.name}';
                                      File videoFile = File(tempVideoPath);
                                      await videoFile.writeAsBytes(await file.readAsBytes());
                                      if (!context.mounted) return;

                                      Navigator.of(context).pop(videoFile);
                                    },
                                    style: theme.elevatedButtonTheme.style?.copyWith(
                                      fixedSize: const WidgetStatePropertyAll(
                                        Size(100, 50),
                                      ),
                                    ),
                                    child: const Text("Next"),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            recording: (r) {
              CameraSettings cameraSettings = r.camSettings;
              CameraDescription camera = r.camera;
              CameraController cameraController = r.controller;

              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Listener(
                    onPointerDown: (_) {
                      cameraCubit.modifyCameraSettings(
                        cameraSettings: cameraSettings.copyWith(
                          pointersOnScreen: cameraSettings.pointersOnScreen + 1,
                        ),
                      );
                    },
                    onPointerUp: (_) {
                      cameraCubit.modifyCameraSettings(
                        cameraSettings: cameraSettings.copyWith(
                          pointersOnScreen: cameraSettings.pointersOnScreen - 1,
                        ),
                      );
                    },
                    child: LayoutBuilder(
                      builder: (_, constraints) {
                        return SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          child: CameraPreview(
                            cameraController,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onScaleStart: (d) {},
                              onScaleUpdate: (d) async {
                                if (d.pointerCount != 2) return;

                                double zoomLevel = (cameraSettings.currentZoom * d.scale).clamp(
                                  cameraSettings.minZoom,
                                  cameraSettings.maxZoom,
                                );

                                cameraCubit.modifyCameraSettings(
                                  cameraSettings: cameraSettings.copyWith(
                                    currentZoom: zoomLevel,
                                  ),
                                );
                              },
                              onTapDown: (details) {
                                final Offset offset = Offset(
                                  details.localPosition.dx / constraints.maxWidth,
                                  details.localPosition.dy / constraints.maxHeight,
                                );

                                cameraCubit.modifyCameraSettings(
                                  cameraSettings: cameraSettings.copyWith(
                                    exposurePoint: offset,
                                    focusPoint: offset,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          cameraCubit.stopRecording(
                            camera: camera,
                            cameraController: cameraController,
                          );
                        },
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
                              color: Colors.white70,
                              size: 70,
                              blendMode: BlendMode.srcATop,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formatDuration(
                          cameraSettings.recordDuration ?? const Duration(),
                        ),
                        style: theme.textTheme.titleMedium?.copyWith(color: Colors.greenAccent),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

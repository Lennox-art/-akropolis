import 'dart:async';

import 'package:akropolis/components/toast/toast.dart';
import 'package:akropolis/features/camera_view/models/camera_models.dart';
import 'package:akropolis/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_state.dart';

part 'camera_cubit.freezed.dart';

class CameraCubit extends Cubit<CameraState> {
  final List<CameraDescription> _deviceCameras = [];
  CameraSettings _cameraSettings = const DefaultCameraSettings();
  CameraController? _cameraController;
  Timer? _recordTimer;
  final Stopwatch _stopwatch = Stopwatch();

  CameraCubit() : super(const CameraState.uninitialized());

  Future<List<CameraDescription>> initializeCamera() async {
    try {
      log.debug("Calling Initializing camera: Current state is $state");

      if (state is! CameraUninitializedState) return _deviceCameras;

      emit(CameraLoadingState());

      log.debug("Begin Initializing camera");

      List<CameraDescription> cameras = await availableCameras();
      _deviceCameras.addAll(cameras);

      if (cameras.isEmpty) {
        emit(
          CameraInitializedState(
            toast: const ToastInfo(
              title: "Initialization",
              message: "No cameras on device",
            ),
            deviceCameras: cameras,
          ),
        );
        return _deviceCameras;
      }

      emit(
        CameraInitializedState(
          deviceCameras: cameras,
        ),
      );

      return _deviceCameras;
    } on CameraException catch (e, trace) {
      addError(e, trace);
      return _deviceCameras;
    }
  }

  Future<void> chooseCamera({
    required CameraDescription camera,
  }) async {
    try {
      log.debug("Calling Choosing camera: Current state is $state");

      if (state is! CameraInitializedState && state is! CameraPreviewState) return;

      emit(CameraLoadingState());

      log.info("Begin Choosing camera $camera");

      final CameraController cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: _cameraSettings.enableAudio,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await cameraController.initialize();

      _cameraController = cameraController;

      double minAvailableZoom = await cameraController.getMinZoomLevel();
      double maxAvailableZoom = await cameraController.getMaxZoomLevel();
      double maxExposureOffset = await cameraController.getMaxExposureOffset();
      double minExposureOffset = await cameraController.getMinExposureOffset();

      //Set defaults camera control
      await cameraController.setFocusMode(_cameraSettings.focusMode);
      await cameraController.setExposureMode(_cameraSettings.exposureMode);
      await cameraController.setFlashMode(_cameraSettings.flashMode);
      await cameraController.lockCaptureOrientation(_cameraSettings.deviceOrientation);

      _cameraSettings = _cameraSettings.copyWith(
        minZoom: minAvailableZoom,
        maxZoom: maxAvailableZoom,
        maxExposureOffset: maxExposureOffset,
        minExposureOffset: minExposureOffset,
      );

      emit(
        CameraPreviewState(
          deviceCameras: _deviceCameras,
          camera: camera,
          cameraController: cameraController,
          camSettings: _cameraSettings,
        ),
      );
    } on CameraException catch (e, trace) {
      addError(e, trace);
    }
  }

  void modifyCameraSettings({
    required CameraSettings cameraSettings,
  }) {
    try {
      log.debug("Calling Modifying camera settings $cameraSettings: Current state is $state");

      if (state is! CameraPreviewState && state is! CameraRecordingState) return;

      log.info("Begin modifying camera settings");

      state.mapOrNull(
        preview: (p) {
          _cameraSettings = cameraSettings;
          emit(
            CameraPreviewState(
              deviceCameras: p.deviceCameras,
              camera: p.camera,
              cameraController: p.cameraController,
              camSettings: cameraSettings,
            ),
          );
        },
        recording: (r) {
          _cameraSettings = cameraSettings;
          emit(
            CameraRecordingState(
              camera: r.camera,
              controller: r.controller,
              camSettings: cameraSettings,
            ),
          );
        },
      );

      _cameraController?.setZoomLevel(cameraSettings.currentZoom);
      _cameraController?.setFocusPoint(cameraSettings.focusPoint);
      // _cameraController?.setExposurePoint(cameraSettings.exposurePoint);
      _cameraController?.setFlashMode(cameraSettings.flashMode);
      _cameraController?.setFocusMode(cameraSettings.focusMode);
      // _cameraController?.setExposureMode(cameraSettings.exposureMode);
      _cameraController?.lockCaptureOrientation(cameraSettings.deviceOrientation);
    } on CameraException catch (e, trace) {
      addError(e, trace);
    }
  }

  Future<void> startRecording({
    required CameraDescription camera,
    required CameraController cameraController,
  }) async {
    try {
      log.debug("Calling Starting Record: Current state is $state");
      if (state is! CameraPreviewState) return;
      if (_cameraSettings.isRecording) return;

      emit(const CameraLoadingState());

      log.debug("Begin Starting Record: Current state is $state");
      //Prepare recording
      await cameraController.prepareForVideoRecording();

      //Prepare stopwatch
      if (_stopwatch.isRunning) {
        _stopwatch.reset();
        _stopwatch.stop();
      }

      //Start video recording
      await cameraController.startVideoRecording();

      //Start stopwatch
      _stopwatch.start();

      _cameraSettings = _cameraSettings.copyWith(
        recordDuration: _stopwatch.elapsed,
        isRecording: true,
      );

      emit(
        CameraRecordingState(
          camera: camera,
          controller: cameraController,
          camSettings: _cameraSettings,
        ),
      );

      //Every second ...
      _recordTimer = Timer.periodic(
        const Duration(seconds: 1),
        (t) async {

          //If recording, update settings
          if (_cameraSettings.isRecording) {
            log.info("Recoding in progress ${_stopwatch.elapsed.inMinutes} : ${_stopwatch.elapsed.inSeconds}");
            _cameraSettings = _cameraSettings.copyWith(
              recordDuration: _stopwatch.elapsed,
              isRecording: true,
            );

            emit(
              CameraRecordingState(
                camera: camera,
                controller: cameraController,
                camSettings: _cameraSettings,
              ),
            );

            return;
          }
        },
      );
    } on CameraException catch (e, trace) {
      addError(e, trace);
    }
  }

  Future<void> pauseRecording() async {
    await _cameraController?.pausePreview();
    if (_cameraController?.value.isRecordingVideo ?? false) {
      await _cameraController?.pauseVideoRecording();
    }
  }

  Future<void> resumeRecording() async {
    await _cameraController?.resumePreview();
    if (_cameraController?.value.isRecordingPaused ?? false) {
      await _cameraController?.resumeVideoRecording();
    }
  }

  Future<void> stopRecording({
    required CameraDescription camera,
    required CameraController cameraController,
  }) async {
    try {
      log.debug("Calling Stopping Record: Current state is $state");
      if (state is! CameraRecordingState) return;
      if (!_cameraSettings.isRecording) return;

      emit(const CameraLoadingState());

      XFile data = await cameraController.stopVideoRecording();
      log.info("Begin Stop Recording for ${_stopwatch.elapsed.inMinutes} : ${_stopwatch.elapsed.inSeconds}");

      _cameraSettings = _cameraSettings.copyWith(
        cameraFile: data,
        recordDuration: _stopwatch.elapsed,
        isRecording: false,
      );

      //Stop stopwatch
      _stopwatch.reset();
      _stopwatch.stop();
      _recordTimer?.cancel();

      emit(
        CameraPreviewState(
          camera: camera,
          deviceCameras: _deviceCameras,
          cameraController: cameraController,
          camSettings: _cameraSettings,
          toast: const ToastSuccess(
            message: "Recoding saved",
          ),
        ),
      );
    } on CameraException catch (e, trace) {
      addError(e, trace);
    }
  }

  void dispose() {
    _cameraController?.dispose();
    _cameraController = null;

    if (_recordTimer != null && _recordTimer!.isActive) {
      _recordTimer!.cancel();
    }
    _stopwatch.reset();
    _stopwatch.stop();

    emit(
      CameraInitializedState(
        toast: const ToastInfo(message: "Stopped camera"),
        deviceCameras: _deviceCameras,
      ),
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    late ToastMessage toast;
    if (error is CameraException) {
      String message = switch (error.code) {
        'CameraAccessDenied' => 'You have denied camera access.',
        'CameraAccessDeniedWithoutPrompt' => 'Please go to Settings to enable camera access.',
        'CameraAccessRestricted' => 'Camera access is restricted.',
        'AudioAccessDenied' => 'You have denied audio access.',
        'AudioAccessDeniedWithoutPrompt' => 'Please go to Settings to enable audio access.',
        'AudioAccessRestricted' => 'Audio access is restricted.',
        _ => 'Error: ${error.code}\n${error.description}'
      };

      toast = ToastError(
        title: error.code,
        message: message,
      );
    } else {
      toast = ToastError(
        title: "Error",
        message: error.toString(),
      );
    }

    log.error(
      toast.message,
      trace: stackTrace,
    );

    emit(
      state.map(
        loading: (s) => s.copyWith(toast: toast),
        uninitialized: (s) => s.copyWith(toast: toast),
        initialized: (s) => s.copyWith(toast: toast),
        preview: (s) => s.copyWith(toast: toast),
        recording: (s) => s.copyWith(toast: toast),
      ),
    );
    super.onError(error, stackTrace);
  }
}

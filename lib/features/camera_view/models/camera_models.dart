import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_models.freezed.dart';

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
    @Default(FocusMode.auto) FocusMode focusMode,
    @Default(FlashMode.auto) FlashMode flashMode,
    @Default(ExposureMode.auto) ExposureMode exposureMode,
    @Default(DeviceOrientation.portraitUp) DeviceOrientation deviceOrientation,
    Duration? recordDuration,
    @Default(false) bool isRecording,
    XFile? cameraFile,
  }) = DefaultCameraSettings;
}

extension LensDirectionIcon on CameraLensDirection {
  IconData get iconData {
    return switch (this) {
      CameraLensDirection.front => Icons.camera_front_outlined,
      CameraLensDirection.back => Icons.camera_rear_outlined,
      CameraLensDirection.external => Icons.camera_outlined,
    };
  }

  String get title {
    return switch (this) {
      CameraLensDirection.front => "Front Camera",
      CameraLensDirection.back => "Back Camera",
      CameraLensDirection.external => "External Camera",
    };
  }
}
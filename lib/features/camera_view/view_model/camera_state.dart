part of 'camera_cubit.dart';

@freezed
class CameraState with _$CameraState {

  const factory CameraState.loading({
    ToastMessage? toast,
  }) = CameraLoadingState;

  const factory CameraState.uninitialized({
    ToastMessage? toast,
  }) = CameraUninitializedState;

  const factory CameraState.initialized({
    required List<CameraDescription> deviceCameras,
    ToastMessage? toast,
  }) = CameraInitializedState;

  const factory CameraState.preview({
    required List<CameraDescription> deviceCameras,
    required CameraDescription camera,
    required CameraController cameraController,
    required CameraSettings camSettings,
    ToastMessage? toast,
  }) = CameraPreviewState;

  const factory CameraState.recording({
    required CameraDescription camera,
    required CameraController controller,
    required CameraSettings camSettings,
    ToastMessage? toast,
  }) = CameraRecordingState;
}

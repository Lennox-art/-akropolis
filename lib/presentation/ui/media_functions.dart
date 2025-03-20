import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:akropolis/data/models/local_models/local_models.dart';
import 'package:exception_base/exception_base.dart';
import 'package:image_picker/image_picker.dart';

Future<Result<MediaBlobData>> pickImageFromDevice() async {
  try {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return Result.error(
        failure: AppFailure(
          message: "No image found",
          failureType: FailureType.illegalStateFailure,
        ),
      );
    }

    MediaBlobData blobData = MediaBlobData(
      blob: await file.readAsBytes(),
      mediaType: MediaType.image,
    );

    return Result.success(data: blobData);
  } catch (e, trace) {
    return Result.error(
      failure: AppFailure(
        message: e.toString(),
        trace: trace,
      ),
    );
  }
}
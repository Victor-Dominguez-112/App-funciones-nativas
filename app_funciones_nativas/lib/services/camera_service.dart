import 'package:image_picker/image_picker.dart';

class CameraService {
  CameraService({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  Future<XFile?> takePhoto() {
    return _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 85);
  }
}

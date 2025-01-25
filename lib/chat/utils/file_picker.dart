

import 'package:file_picker/file_picker.dart';

Future<String?> pickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.first.path;
    }
  } catch (e) {
    print('Error picking file: $e');
  }
  return null;
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../utilities/utilities.dart';
import '../../models/error_model.dart';
import '../../models/success_model.dart';
import 'upload_file_response_model.dart';
import 'upload_repo.dart';

class UploadBloc {
  final BehaviorSubject<List<String>> _filesSubject = BehaviorSubject.seeded([]);
  BehaviorSubject<UploadFileResponseModel> successSubject =
      BehaviorSubject();
  BehaviorSubject<SuccessModel> deleteFileSuccessSubject = BehaviorSubject();
  BehaviorSubject<ErrorModel> errorSubject = BehaviorSubject();

  Future uploadSingleFile() async {
    FormData formData = FormData();
    for (var file in _filesSubject.value) {
      log('file : $file');
      formData.files.add(MapEntry(
        "file",
        MultipartFile.fromFileSync(file, filename: file.split('/').last),
      ));
    }
    Utilities.showLoadingDialog();
    Response response = await UploadRepo().uploadFile(formData);
    Utilities.hideLoadingDialog();

    if (response.statusCode == 200) {
      successSubject.sink.add(UploadFileResponseModel.fromJson(response.data));
      return response;
    } else {
      errorSubject.sink
          .add(ErrorModel(status: 500, message: 'ErrorWhileUploading'));
    }
  }

  addFile(String filePath) {
    List<String> files = _filesSubject.value;
    files.add(filePath);
    _filesSubject.sink.add(files);
  }

  setFile(String filePath) {
    _filesSubject.value.clear();
    _filesSubject.sink.add([filePath]);
  }

  removeFile(String filePath) {
    int index = _filesSubject.value.indexOf(filePath);
    _filesSubject.value.removeAt(index);
    List<String> tempList = _filesSubject.value;
    removeAllFiles();
    _filesSubject.sink.add(tempList);
  }

  replaceFile(String filePath) {
    _filesSubject.value.remove(filePath);
    _filesSubject.sink.add(_filesSubject.value);
  }

  removeAllFiles() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _filesSubject.sink.add([]);
    });
  }

  getAllFiles() {
    return _filesSubject.value;
  }

  Future deleteFile(String url) async {
    Utilities.showLoadingDialog();
    Response response = await UploadRepo().deleteFile(url);
    Utilities.hideLoadingDialog();

    if (response.statusCode == 200 || response.statusCode == 204) {
      deleteFileSuccessSubject.sink
          .add(SuccessModel(status: 200, message: 'Success'));
      return response;
    } else {
      errorSubject.sink.add(ErrorModel(status: 500, message: 'Error'));
    }
  }
}

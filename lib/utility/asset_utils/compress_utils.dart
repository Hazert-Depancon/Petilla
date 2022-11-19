// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:io';
import 'dart:math';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petilla_app_project/core/constants/enums/file_type_enum.dart';

class CompressUtils {
  static final CompressUtils _compressUtils = CompressUtils._internal();
  factory CompressUtils() {
    return _compressUtils;
  }
  CompressUtils._internal();

  Future<File?> compressAndGetFile(File file) async {
    final dir = await getTemporaryDirectory();

    File? result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      "${dir.absolute.path}/temp.jpg",
      quality: 40,
    );

    print("BEFORE: ${await getFileSize(file)}");
    print("AFTER: ${await getFileSize(result!)}");

    return result;
  }

  Future<String> getFileSize(File file) async {
    final int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    List<String> suffixes = <String>[
      FileTypeEnum.B.toString(),
      FileTypeEnum.KB.toString(),
      FileTypeEnum.MB.toString(),
      FileTypeEnum.GB.toString(),
      FileTypeEnum.TB.toString(),
      FileTypeEnum.PB.toString(),
      FileTypeEnum.EB.toString(),
      FileTypeEnum.ZB.toString(),
      FileTypeEnum.YB.toString()
    ];
    final int i = (log(bytes) / log(1024)).floor();
    return "${(bytes / pow(1024, i)).toStringAsFixed(3)} ${suffixes[i]}";
  }
}

import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

//全局key-截图key
final GlobalKey boundaryKey = GlobalKey();

class RepaintBoundaryUtils {
//生成截图
  /// 截屏图片生成图片流ByteData
  Future<String> captureImage() async {
    RenderRepaintBoundary? boundary = boundaryKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary?;
    double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
    var image = await boundary!.toImage(pixelRatio: dpr);
    // 将image转化成byte
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    var filePath = "";

    Uint8List pngBytes = byteData!.buffer.asUint8List();
    // 获取手机存储（getTemporaryDirectory临时存储路径）
    Directory applicationDir = await getTemporaryDirectory();
    // getApplicationDocumentsDirectory();
    // 判断路径是否存在
    bool isDirExist = await Directory(applicationDir.path).exists();
    if (!isDirExist) Directory(applicationDir.path).create();
    // 直接保存，返回的就是保存后的文件
    File saveFile = await File(
        applicationDir.path + "${DateTime.now().toIso8601String()}.jpg")
        .writeAsBytes(pngBytes);
    filePath = saveFile.path;
    // if (Platform.isAndroid) {
    //   // 如果是Android 的话，直接使用image_gallery_saver就可以了
    //   // 图片byte数据转化unit8
    //   Uint8List images = byteData!.buffer.asUint8List();
    //   // 调用image_gallery_saver的saveImages方法，返回值就是图片保存后的路径
    //   String result = await ImageGallerySaver.saveImage(images);
    //   // 需要去除掉file://开头。生成要使用的file
    //   File saveFile = new File(result.replaceAll("file://", ""));
    //   filePath = saveFile.path;
    //
    //
    // } else if (Platform.isIOS) {
    //   // 图片byte数据转化unit8
    //
    // }

    return filePath;
  }
}
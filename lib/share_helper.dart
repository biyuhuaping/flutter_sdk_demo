import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {
  GlobalKey repaintWidgetKey = GlobalKey(); // 绘图key值

  /// 分享图片
  Future<void> onSharePlusShare(GlobalKey repaintWidgetKey) async {
    this.repaintWidgetKey = repaintWidgetKey;
    Uint8List? sourceBytes = await _capturePngToByteData();
    if (sourceBytes == null) {
      return;
    }
    Directory tempDir = await getTemporaryDirectory();
    String storagePath = tempDir.path;
    File file = File(
        '$storagePath/xyy_share_image_${DateTime.now().millisecondsSinceEpoch}.png');
    debugPrint('==filepath: ${file.path}');
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsBytesSync(sourceBytes);
    await Share.shareXFiles([XFile(file.path)]);
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("分享图片成功")));
  }

  /// 截屏图片生成图片，返回图片二进制
  Future<Uint8List?> _capturePngToByteData() async {
    try {
      RenderRepaintBoundary? boundary = repaintWidgetKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return null;
      }
      // 获取当前设备的像素比
      double dpr = ui.window.devicePixelRatio;
      ui.Image image = await boundary.toImage(pixelRatio: dpr);
      final sourceBytes = await image.toByteData(format: ui.ImageByteFormat.png);
      return sourceBytes?.buffer.asUint8List();
    } catch (e) {
      return null;
    }
  }
}

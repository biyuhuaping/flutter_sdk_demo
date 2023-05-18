import 'package:flutter/material.dart';
import 'repaintBoundary_utils.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {

  static bool wxIsInstalled = false;

  //share_plus分享
  static void onSharePlusShare(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;
    List<String> imagePaths = [];

    //获取截图地址
    String filePath = await RepaintBoundaryUtils().captureImage();
    //Share.shareFiles内可以传多张图片，里面是个数组，所以每次要将数组清空，再将新的截图添加到数组中
    imagePaths.clear();
    imagePaths.add(filePath);
    print("================$filePath");
    //分享
    await Share.shareFiles(imagePaths,
        text: "机构详情",
        subject: "",
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}

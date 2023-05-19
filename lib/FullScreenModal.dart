import 'package:flutter/material.dart';
import 'share_helper.dart';
import 'share_content_page.dart';

// this class defines the full-screen semi-transparent modal dialog
// by extending the ModalRoute class
class FullScreenModal extends ModalRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        height: MediaQuery.of(context).size.height -128,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ShareContentPage(),
              color: Colors.green,
              // height: 1000,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildMaterialButton("关闭", Colors.black.withOpacity(0.5), (){
                  Navigator.pop(context);
                }),
                buildMaterialButton("分享", Colors.orange, (){
                  Navigator.pop(context);
                  //share_plus 分享
                  ShareHelper.onSharePlusShare(context);
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // add fade animation
    return FadeTransition(
      opacity: animation,
      // add slide animation
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        // add scale animation
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }

  //关闭、分享 按钮
  MaterialButton buildMaterialButton(String titleStr, Color col, VoidCallback onPressed) {
    return MaterialButton(
      // 背景颜色
      color: col,
      // 边框样式
      shape: const RoundedRectangleBorder(
        // 边框颜色
        side: BorderSide(
          color: Colors.white,
          width: 1,
        ),
        // 边框圆角
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      // 按钮高度
      height: 50,
      // 按钮最小宽度
      minWidth: 163,
      // 点击事件
      onPressed: onPressed,
      child: Text(
        titleStr,
        style:const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

}


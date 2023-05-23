import 'package:flutter/material.dart'; //SharePageView
import 'package:flutter/cupertino.dart';
import 'share_content_page.dart';

class SharePageView extends StatefulWidget {
  @override
  createState() => new SharePageViewState();
}

class SharePageViewState extends State<SharePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Container(
        padding: EdgeInsets.only(left: 17, right: 17),
        child: ShareContentPage(),
        color: Colors.transparent,
      ),
      // floatingActionButton: Stack(
      //   alignment: Alignment.bottomCenter,
      //   children: [
      //     Positioned(
      //       left: 17,
      //       child: buildMaterialButton("关闭", onPressed:() {
      //         Navigator.pop(context);
      //       }),
      //     ),
      //     Positioned(
      //       right: 17,
      //       child: buildMaterialButton("分享", hasGradient: true, onPressed:() {
      //         Navigator.pop(context);
      //         //share_plus 分享
      //         ShareHelper.onSharePlusShare(context);
      //       }),
      //     ),
      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //按钮：关闭、分享
  Widget buildMaterialButton(String title, {bool hasGradient = false, VoidCallback? onPressed}) {
     return Container(
      height: 50,
      width: 163,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: !hasGradient
            ? Border.all(color: Colors.white, width: 1.0,)
            : null,
        gradient: hasGradient
            ? const LinearGradient(
          colors: [Color(0xFFFB9C02), Color(0xFFFB6302)],// 渐变的颜色数组
          begin: Alignment.centerLeft, // 渐变的起点位置
          end: Alignment.centerRight, // 渐变的终点位置
          stops: [0.0, 1.0], // 渐变颜色的分布位置，范围是0.0到1.0
        )
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart'; //SharePageView
import 'package:flutter/cupertino.dart';
import 'share_helper.dart';
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
      floatingActionButton: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            left: 17,
            child: buildMaterialButton("关闭", onPressed:() {
              Navigator.pop(context);
            }),
          ),
          Positioned(
            right: 17,
            child: buildMaterialButton("分享", hasImg: true, onPressed:() {
              Navigator.pop(context);
              //share_plus 分享
              ShareHelper.onSharePlusShare(context);
            }),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //按钮：关闭、分享
  Widget buildMaterialButton(String title, {bool hasImg = false, VoidCallback? onPressed}) {
    return Container(
      height: 50,
      width: 163,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
        image: hasImg ? DecorationImage(image: AssetImage('assets/share_btn.png'), fit: BoxFit.cover) : null,
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

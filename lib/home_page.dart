import 'package:flutter/material.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'share_page.dart';

// This is the main screen of the application
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dragController = DragController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KindaCode.com')),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    dragController.showWidget();
                  },
                  child: Text("显示悬浮按钮"),
                ),
                TextButton(
                  onPressed: () {
                    dragController.hideWidget();
                  },
                  child: Text("隐藏悬浮按钮"),
                ),
                TextButton(
                  onPressed: () => _showSharesDialog(context),
                  child: Text("显示半透明视图"),
                ),
              ],
            ),
          ),
          //可拖拽的悬浮按钮
          DraggableWidget(
            bottomMargin: 200,
            topMargin: 0,
            intialVisibility: true,
            horizontalSpace: 0,
            shadowBorderRadius: 0,
            child: Container(
              height: 50,
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: const Icon(Icons.add),
            ),
            initialPosition: AnchoringPosition.bottomRight,
            dragController: dragController,
          )
        ],
      ),
    );
  }

  // 弹出分享Dialog
  Future<int?> _showSharesDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,//点击背后蒙层是否关闭弹框，默认为 true
      builder: (_) => Padding(
        padding: EdgeInsets.all(17),
        child: ShareContentPage(),
      ),
    );
  }
}

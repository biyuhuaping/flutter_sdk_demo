import 'package:flutter/material.dart';
import 'package:flutter_sdk_demo/FullScreenModal.dart';
import 'share_helper.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'share_content_page.dart';

// This is the main screen of the application
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dragController = DragController();

  void _showModal(BuildContext context) {
    Navigator.of(context).push(FullScreenModal());
  }

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
                  onPressed: () => _showModal(context),
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
}

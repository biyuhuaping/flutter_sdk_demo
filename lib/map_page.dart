import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class CustomerMapPage extends StatefulWidget {
  const CustomerMapPage({Key? key}) : super(key: key);

  @override
  State<CustomerMapPage> createState() => _CustomerMapPageState();
}

class _CustomerMapPageState extends State<CustomerMapPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Container(
        child: Center(
          child: Text("$_counter"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      Share.shareXFiles([XFile('assets/美女1.jpg')]);

    });


    // await Share.shareXFiles([XFile('assets/美女1.jpg')],
    //     // sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
    // );
    // Share.shareXFiles([XFile('/Users/zb/flutter_sdk_demo/web/icons/Icon-192.png')]);

    // Share.shareFiles(['assets/美女1.jpg']);
  }
}

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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'This is a title',
              style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: ShareContentPage(),
              color: Colors.red,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.close),
              label: const Text('关闭'),
              onPressed: () {
                //share_plus 分享
                ShareHelper.onSharePlusShare(context);
                //微信SDK分享
                // ShareHelper.onShareWx(context);
                Navigator.pop(context);
              },
            )
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
}


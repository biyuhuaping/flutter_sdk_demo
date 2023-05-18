import 'package:flutter/material.dart';

class Data {
  final String title;
  final List<String> items;

  Data(this.title, this.items);
}

class ShareContentPage extends StatelessWidget {
  final List<Data> dataList = [
    Data('Group 1', ['Item 1', 'Item 2', 'Item 3']),
    Data('Group 2', ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']),
    Data('Group 3', ['Item 1']),
  ];

  @override
  Widget build11(BuildContext context) {
    return Container(
      color: Colors.green,
      child: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            buildHeaderView(),
            buildContentView(context),
            buildFooterView()
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Image.asset(
            'assets/share_header_BD.png',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            top: 130,
            child: Container(
              color: Colors.black.withOpacity(0.5), // 覆盖层的背景颜色
              // physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // buildHeaderView(),
                  buildContentView(context),
                  buildFooterView(),
                  // SizedBox(height: 1000), // 增加一些高度以便滚动显示
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //头部图片
  Widget buildHeaderView() {
    return Container(
      color: Colors.transparent,
      child: Image.asset(
        'assets/share_header_BD.png',
        // width: 7,
        // height: 12,
      ),
    );
  }

  //排名数据
  Widget buildContentView(BuildContext context) {
    List<String> imageUrls = [
      'assets/share_dept1.png',
      'assets/share_dept2.png',
      'assets/share_dept3.png',
    ];

    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (ctx, index) {
        ImageProvider image = AssetImage(imageUrls[index]);
        List<String> texts = ['Text 1', 'Text 2', 'Text 3'];
        Widget widget = buildImageWithText(image, texts);
        return buildContentGroup(
          context: context,
          child: widget
        );
      },
    );
    return buildContentGroup(
        context: context,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (ctx, index) {
            ImageProvider image = AssetImage(imageUrls[index]);
            List<String> texts = ['Text 1', 'Text 2', 'Text 3'];
            Widget widget = buildImageWithText(image, texts);
            return widget;
          },
        )
    );
  }

  //排名数据组
  Widget buildContentGroup({required BuildContext context, Widget? child}){
    return Container(
      margin: EdgeInsets.only(bottom: 10),//外边距
      padding: EdgeInsets.all(5),//内边距
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4)
      ),
      width: MediaQuery.of(context).size.width -10,
      child: child,
    );
  }


  //item 单个数据 图片和文字
  Widget buildImageWithText(ImageProvider image, List<String> texts) {
    List<String> subTitles = [
      'Subtitle 1',
      'Subtitle 2',
      'Subtitle 3',
    ];
    return Row(
      children: [
        Container(
          width: 110, // 图片宽度
          height: 110, // 图片高度
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 16), // 图片和文字之间的间距
        Expanded(
          child: customWidget("55万+", texts, subTitles),
        ),
      ],
    );
  }

  Widget customWidget(String title, List<String> mainTitles, List<String> subTitles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mainTitles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(mainTitles[index]),
              subtitle: Text(subTitles[index]),
            );
          },
        ),
      ],
    );
  }


  //尾部样式
  Widget buildFooterView() {
    return const Text("footerView");
  }
}

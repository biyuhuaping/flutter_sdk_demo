import 'package:flutter/material.dart';

class Data {
  final String title;
  final List<String> items;

  Data(this.title, this.items);
}

class ShareContentPage extends StatefulWidget {
  @override
  State<ShareContentPage> createState() => _ShareContentPageState();
}

class _ShareContentPageState extends State<ShareContentPage> {
  final List<Data> dataList = [
    Data('Group 1', ['Item 1', 'Item 2', 'Item 3']),
    Data('Group 2', ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']),
    Data('Group 3', ['Item 1']),
  ];

  bool isButton1Selected = true;
  int selectedType = 1; //默认选中BD=1，KA=2

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 80),//弹框顶部位置
      height: MediaQuery.of(context).size.height - 200,//弹框整体高度
      decoration: BoxDecoration(
        // color: Color(0xFFFB8702),
        borderRadius: BorderRadius.circular(9),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width-34,
          child: Stack(
            children: <Widget>[
              buildHeaderButtons(context),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Image.asset(
                  selectedType == 1
                      ? 'assets/share_header_BD.png'
                      : 'assets/share_header_KA.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 180,
                child: Container(
                  height: 800,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFFFB8702),
                ),
              ),
              Positioned.fill(
                top: 150,
                child: buildContainer(),
              )
            ],
          ),
        ),
      ),
    );
    // return ListView(
    //   children:
    // );
  }

  Widget buildContainer() {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // buildHeaderView(),
          buildContentView(context),
          buildFooterView(),
          // SizedBox(height: 1000), // 增加一些高度以便滚动显示
        ],
      ),
    );
  }

  //头部按钮部件
  Widget buildHeaderButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Color(0xFFFFEDD1),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: customButton("BD榜", selectedType == 1, 1),
          ),
          Expanded(
            child: customButton("KA榜", selectedType == 2, 2),
          ),
        ],
      ),
    );
  }

  //按钮
  Widget customButton(String title, bool selected, int type) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFEDD1),
        borderRadius: BorderRadius.circular(8),
        image: selected
            ? DecorationImage(
                image: AssetImage('assets/share_bdka.png'),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedType = type;
            isButton1Selected = selected;
          });
        },
        child: Text(
          title,
          style: TextStyle(
              color: selected ? Colors.white : Color(0xFFFC6105), fontSize: 18),
        ),
      ),
    );
  }

  //头部图片
  Widget buildHeaderView() {
    return Container(
      color: Colors.green,
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

    return Column(
      children: imageUrls.map((imageUrl) {
        ImageProvider image = AssetImage(imageUrl);
        List<String> texts = ['Text 1', 'Text 2', 'Text 3'];
        Widget widget = buildImageWithText(image, texts);
        return buildContentGroup(context: context, child: widget);
      }).toList(),
    );
  }

  //排名数据组
  Widget buildContentGroup({required BuildContext context, Widget? child}) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10), //外边距
      padding: EdgeInsets.all(5), //内边距
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4)),
      // width: MediaQuery.of(context).size.width - 10,
      child: child,
    );
  }

  //item 单组数据 图片和文字
  Widget buildImageWithText(ImageProvider image, List<String> texts) {
    List<String> subTitles = [
      'Subtitle 1',
      'Subtitle 2',
      'Subtitle 3',
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          child: buildItemWidget("55万+", texts, subTitles),
        ),
      ],
    );
  }

  // 每条内容
  Widget buildItemWidget(
      String title, List<String> mainTitles, List<String> subTitles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red),
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

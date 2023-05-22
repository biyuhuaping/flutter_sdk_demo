import 'package:flutter/material.dart';

class Data {
  final String title;
  final List<String> items;

  Data(this.title, this.items);
}

class ShareContentPage extends StatefulWidget {
  const ShareContentPage({Key? key}) : super(key: key);

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
  // double containerHeight = MediaQuery.of(context).size.height - 200; //弹框整体默认高度
  // double screenHeight = WidgetsBinding.instance!.window.physicalSize.height / WidgetsBinding.instance!.window.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height - 200;

    return Container(
      //弹框视图容器
      margin: const EdgeInsets.only(top: 80), // 弹框顶部位置
      height: containerHeight, // 弹框整体高度
      decoration: BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(9),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeaderButtons(context),
            Image.asset(
              selectedType == 1
                  ? 'assets/share_header_BD.png'
                  : 'assets/share_header_KA.png',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFB8702),
                // color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(13),
                ),
              ),
              child: Column(
                children: <Widget>[
                  buildContentView(context), //排名数据
                  buildEncourageText(), //底部激励文本
                  buildFooterView(), //底部白色内容
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //头部按钮：BD榜、KA榜
  Widget buildHeaderButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDD1),
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

  //按钮样式
  Widget customButton(String title, bool selected, int type) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDD1),
        borderRadius: BorderRadius.circular(8),
        image: selected
            ? const DecorationImage(
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
              color: selected ? Colors.white : const Color(0xFFFC6105),
              fontSize: 18),
        ),
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

    List<Widget> children = imageUrls.map((imageUrl) {
      ImageProvider image = AssetImage(imageUrl);
      Widget widget = buildItemImageWithText(image);
      return buildContentGroup(widget);
    }).toList();

    //如果是自己，也是登顶了，就显示登顶样式
    if (1 == 1){
      // 替换第一个元素
      children[0] = buildGroupOfMyTop();
    }

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 9),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  // 每个分组的样式
  Widget buildContentGroup(Widget? child) {
    return Container(
      margin: const EdgeInsets.only(left: 9, right: 9, bottom: 9), //外边距
      padding: const EdgeInsets.all(5), //内边距
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }

  //我登顶的样式
  Widget buildGroupOfMyTop(){
    Widget widget = Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        // border: Border.all(
        //   color: Color(0xFFCC7200), // 边框的颜色
        //   width: 1.0, // 边框的宽度
        // ),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF9EC), Color(0xFFFEDEB6)], // 渐变的颜色数组
          begin: Alignment.topCenter, // 渐变的起点位置
          end: Alignment.bottomCenter, // 渐变的终点位置
          stops: [0.0, 1.0], // 渐变颜色的分布位置，范围是0.0到1.0
        ),
      ),
      child: buildTopImageWithText(),
    );
    Widget stack = Stack(
      children: [
        widget,
        Align(
          alignment: Alignment.center,
          child: Image.asset('assets/share_top.png',width: 127, height: 30,),
        ),
      ],
    );
    return stack;
  }

  //登顶内容：图片、文字
  Widget buildTopImageWithText() {
    Map<String, String> amountMap = formatAmount(6650000);

    return Container(
      // color: Colors.green,
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/share_dept1.png',
            ),
          ),
          const SizedBox(width: 7.5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      amountMap['value']!,
                      style: const TextStyle(
                        fontSize: 44,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(amountMap['unit']!,
                      style: const TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ],
                ),
                // SizedBox(height: 2),
                RichText(
                  text:const TextSpan(
                    children: [
                      TextSpan(
                        text: '天玑',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '（胡高忠）',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //item 单组数据 图片和文字
  Widget buildItemImageWithText(ImageProvider image) {
    List<String> texts = [
      '花茶（王志杰）',
      '花名（姓名）',
      // 'Text 3'
    ];
    List<String> subTitles = [
      '华北一区/山北销售部/销售一组',
      '华北一区/山北销售部/销售二组',
      '华北一区/山北销售部/销售三组',
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        const SizedBox(width: 16), // 图片和文字之间的间距
        Expanded(
          child: buildItemWidget("55万+", texts, subTitles),
        ),
      ],
    );
  }

  // 每条内容
  Widget buildItemWidget(
      String title,
      List<String> mainTitles,
      List<String> subTitles,
      ) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mainTitles.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return buildItemFormatText(5000);
            Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        } else {
          final itemIndex = index - 1;
          return Container(
            // color: Colors.red,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitles[itemIndex],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitles[itemIndex],
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  //处理item内，
  Widget buildItemFormatText(double amount) {
    String string; // 金额
    String unit; // 单位
    if (amount < 10000) {
      string = amount.toString(); // 元
      unit = '元';
    } else {
      int tenThousand = amount ~/ 10000;
      string = '$tenThousand'; // 万+
      unit = '万+';
    }

    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 24,
        color: Colors.red,
        fontWeight: FontWeight.w600,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            string,
            style: const TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(unit),
        ],
      ),
    );
  }

  /// 格式化金额和单位 元/万+
  Map<String, String> formatAmount(double amount) {
    String value; // 金额
    String unit; // 单位
    if (amount < 10000) {
      value = amount.toString(); // 元
      unit = '元';
    } else {
      int tenThousand = amount ~/ 10000;
      value = '$tenThousand'; // 万+
      unit = '万+';
    }
    return {'value': value, 'unit': unit};
  }


  //底部激励文本
  Widget buildEncourageText() {
    return Container(
      color: Color(0xFFFB8702),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Stack(
        children: <Widget>[
          const Positioned(
            top: 0,
            left: 0,
            child: Text(
              '“',
              style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            bottom: -35,
            right: 0,
            child: Text(
              '”',
              style: TextStyle(fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 20, left: 35, bottom: 20, right: 35),
            child: const Text(
              '每一步都是进步，每一天都是起点，坚持不懈就能创造辉煌，相信相信的力量！',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //尾部视图容器
  Widget buildFooterView() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(13),
          bottomRight: Radius.circular(13),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Image.asset('assets/share_bottom_horn.png'),
          Positioned.fill(
            top: 6,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: buildBottomContentView(),
            ),
          ),
        ],
      ),
    );
  }

  //尾部内容
  Widget buildBottomContentView() {
    return Container(
      // color: Colors.blue,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: buildBottomLeftColumn(),
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: buildBottomRightColumn(),
            ),
          ),
        ],
      ),
    );
  }

  //尾部左边内容
  Widget buildBottomLeftColumn() {
    return Container(
      // color: Colors.green,
      child: Row(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/share_logo.png',
              width: 43,
              height: 43,
            ),
          ),
          const SizedBox(width: 7.5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  '天玑（胡高忠）',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '华北一区/销售一组',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF676773),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //尾部右边内容
  Widget buildBottomRightColumn() {
    return Container(
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            '12月28日 星期六',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00B377)),
          ),
          SizedBox(height: 5),
          Text(
            '癸卯兔年 甲子月 壬戌日',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF85858F),
            ),
          ),
        ],
      ),
    );
  }
}

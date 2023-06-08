import 'package:flutter/material.dart';
import 'share_helper.dart';

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
  GlobalKey repaintWidgetKey = GlobalKey(); // 绘图key值

  final List<Data> dataList = [
    Data('Group 1', ['Item 1', 'Item 2', 'Item 3']),
    Data('Group 2', ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5']),
    Data('Group 3', ['Item 1']),
  ];

  bool isButton1Selected = true;
  int selectedType = 1; //默认选中BD=1，KA=2

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height-200;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            height: containerHeight, // 弹框整体高度
            decoration: BoxDecoration(
              // color: Colors.blue,
              borderRadius: BorderRadius.circular(9),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildHeaderButtons(context),
                  buildRepaintBoundary(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            // height: 90,
            // color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildMaterialButton("关闭", onPressed:() {
                  Navigator.pop(context);
                }),
                buildMaterialButton("分享", hasGradient: true, onPressed:() {
                  intervalClick(2);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// 防重复提交
  var  lastPopTime = DateTime.now();
  void intervalClick(int needTime){
    // 防重复提交
    if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: needTime)){
      print(lastPopTime);
      lastPopTime = DateTime.now();
      print("允许点击");
      ShareHelper().onSharePlusShare(repaintWidgetKey);
    }else{
      // lastPopTime = DateTime.now(); //如果不注释这行,则强制用户一定要间隔2s后才能成功点击. 而不是以上一次点击成功的时间开始计算.
      print("请勿重复点击！");
    }
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

  //整个截图部分
  Widget buildRepaintBoundary(){
    double width = MediaQuery.of(context).size.width - 34;
    return RepaintBoundary(
      key: repaintWidgetKey,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(13),),
        child: Column(
          children: [
            Image.asset(
              selectedType == 1
                  ? 'assets/share_header_BD.png'
                  : 'assets/share_header_KA.png',
              fit: BoxFit.cover,
              width: width,
              scale: 114 / 375,
            ),
            Container(
              color: Color(0xFFFB8702),
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
      'assets/share_dept3.png',
    ];

    List<Widget> children = imageUrls.map((imageUrl) {
      ImageProvider image = AssetImage(imageUrl);
      Widget widget = buildGroupContent(image);
      return buildGroupStyle(widget);
    }).toList();

    //如果是自己，也是登顶了，就显示登顶样式
    if (1 == 1) {
      // 替换第一个元素为登顶样式
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

  //我登顶的样式
  Widget buildGroupOfMyTop() {
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
          child: Image.asset(
            'assets/share_top.png',
            width: 127,
            height: 30,
          ),
        ),
      ],
    );
    return stack;
  }

  //登顶内容：图片、文字
  Widget buildTopImageWithText() {
    List<String> amountList = formatAmount(6650000);

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
                      amountList[0],
                      style: const TextStyle(
                        fontSize: 44,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      amountList[1],
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
                  text: const TextSpan(
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

  // 每个分组的样式
  Widget buildGroupStyle(Widget? child) {
    return Container(
      margin: const EdgeInsets.only(left: 9, right: 9, bottom: 9), //外边距
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );
  }

  // 每组数据 图片和文字，底部排名
  Widget buildGroupContent(ImageProvider image) {
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

    String rankType = "23名";//排行类型
    String rankLevelText = "下降6名";//等级文案
    String rankRateText = "23.34%";//超过率文案

    List<Widget> children = [
      Row(
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
      ),
    ];

    //如果有排名内容，就添加widget
    if(1==1){
      children.add(buildGroupBottomContent());
    }
    return Column(
        children: children
    );
  }

  //组内排名内容
  Widget buildGroupBottomContent() {
    int rankType = 23; // 排行类型
    int rankLevel = 6;
    String rankLevelText; // 等级文案
    Color color;
    String rankRateText = "23.34%"; // 超过率文案

    if (rankLevel < 0){
      rankLevelText = '下降${-rankLevel}名';
      color = Color(0xFF00B377);//绿色
    }else if(rankLevel > 0){
      rankLevelText = "上升$rankLevel名";
      color = Color(0xFF00B377);//绿色 TODO:是否展示红色？//Colors.red;//红色
    }else{
      rankLevelText = "相同";
      color = Color(0xFFF9F9F9);//默认的灰色
    }

    return Container(
      padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        border: Border.all(
          color: Color(0xFFDFDFDF), // 边框的颜色
          width: 0.5, // 边框的宽度
        ),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(fontSize: 13, color: Color(0xFF676773)),
          children: [
            TextSpan(
              text: '我的排名',
            ),
            TextSpan(
              text: '$rankType名',
              style: TextStyle(color: Color(0xFF00B377)),
            ),
            TextSpan(
              text: '，比昨天',
            ),
            TextSpan(
              text: rankLevelText,//下降/上升/相同
              style: TextStyle(color: color),
            ),
            TextSpan(
              text: '\n超过全国',
            ),
            TextSpan(
              text: rankRateText,
              style: TextStyle(color: Color(0xFF00B377)),
            ),
            TextSpan(
              text: '的KA',
            ),
          ],
        ),
      ),
    );
  }

  // 每条组内容：
  // 55 万+
  // 花名（姓名）
  // 区域/销售部门
  Widget buildItemWidget(String title, List<String> mainTitles, List<String> subTitles,) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 5,bottom: 5),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mainTitles.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          //55 万+
          return buildItemFormatText(5000);
        } else {
          final itemIndex = index - 1;
          // 花名（姓名）
          // 区域/销售部门
          return Container(
            // color: Colors.red,
            padding: EdgeInsets.only(top: 8, bottom: 8),
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

  //处理item内，//55 元/万+
  Widget buildItemFormatText(double amount) {
    List<String> amountList = formatAmount(15000);

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
            amountList[0],
            style: const TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(amountList[1]),
        ],
      ),
    );
  }

  // 格式化金额和单位 元/万+
  List<String> formatAmount(double amount) {
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
    return [value, unit];
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
              style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Positioned(
            bottom: -35,
            right: 0,
            child: Text(
              '”',
              style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
    return Stack(
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

import 'package:flutter/material.dart';

class JuiceWidget extends StatelessWidget {
  JuiceWidget(JuiceEntity juiceList);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "Arial",
    );
    return AspectRatio(
      aspectRatio: 1.25,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final topPadding = constraints.maxHeight * 0.2;
          final leftPadding = constraints.maxWidth * 0.1;
          final imageWidth = constraints.maxWidth * 0.35;
          return Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: topPadding),
                decoration: BoxDecoration(
                  color: Color(0xFFDC691F),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: topPadding,
                        left: leftPadding,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Juguito de naranja",
                            style: textStyle.copyWith(fontSize: 20),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "\$",
                                  style: textStyle.copyWith(fontSize: 16),
                                ),
                                TextSpan(
                                  text: ("10 pesitos"),
                                  style: textStyle.copyWith(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 80,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Color(0xFFDC691F),
                                textStyle: TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {},
                              child: Text("nya"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: imageWidth,
                    child: Image.asset('assets/juice.png'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class JuiceEntity {
  final String name;
  final String image;
  final String price;
  final Color color;

  JuiceEntity({
    required this.name,
    required this.image,
    required this.price,
    required this.color,
  });
}

class ChallengeScreen extends StatelessWidget {
  final juiceList = [
    JuiceEntity(
      name: "Juguito de limon",
      image: "assets/juice1.png",
      price: "15 pesitos",
      color: Color(0xFFF3BE39),
    ),
    JuiceEntity(
      name: "Juguito de naranja",
      image: "assets/juice2.png",
      price: "10 pesitos",
      color: Color(0xFFDC691F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 38,
            margin: EdgeInsets.only(left: 20, top: 32, right: 20, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/menu.png"),
                Text(
                  "Cherry´s Cafe",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
                Image.asset("assets/bag.png"),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: ListView.builder(
                padding: EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return JuiceWidget(juiceList[index]);
                },
                itemCount: juiceList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

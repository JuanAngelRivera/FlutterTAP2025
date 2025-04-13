import 'dart:ui';
import 'package:flutter/material.dart';

final textStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  fontFamily: "Arial",
);

class JuiceWidget extends StatelessWidget {
  final JuiceEntity juice;

  const JuiceWidget(this.juice, {super.key});

  @override
  Widget build(BuildContext context) {
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
                  color: juice.color,
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
                            juice.name,
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
                                  text: juice.price,
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
                                foregroundColor: juice.color,
                                textStyle: TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            JuiceDetailsPage(juice: juice),
                                  ),
                                );
                              },
                              child: Text("nya"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: imageWidth, child: Image.asset(juice.image)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final int currentCount;
  final Color color;
  final VoidCallback? onIncreaseClicked;
  final VoidCallback? onDecreaseClicked;
  final txtstyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  CounterWidget({
    super.key,
    required this.currentCount,
    required this.color,
    required this.onIncreaseClicked,
    required this.onDecreaseClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16),
          GestureDetector(
            onTap: onDecreaseClicked,
            child: Icon(Icons.remove, color: Colors.white),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 30,
            child: Text(
              currentCount.toString(),
              style: txtstyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: onIncreaseClicked,
            child: Icon(Icons.add, color: Colors.white),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class JuiceDetailsPage extends StatefulWidget {
  final JuiceEntity juice;
  const JuiceDetailsPage({required this.juice, super.key});

  @override
  State<JuiceDetailsPage> createState() => _JuiceDetailsPageState();
}

class _JuiceDetailsPageState extends State<JuiceDetailsPage> {
  var count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final imageHorizontalMargin = constraints.maxWidth * 0.15;
                  final imageHeight = constraints.maxHeight * 0.7;
                  return SizedBox(
                    height: 420,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: widget.juice.color,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                          margin: EdgeInsets.only(bottom: 26),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: imageHorizontalMargin,
                                right: imageHorizontalMargin,
                                bottom: 0,
                              ),
                              child: Image.network(
                                'https://flutter4fun.com/wp-content/uploads/2021/09/full.png',
                                height: imageHeight,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CounterWidget(
                            currentCount: count,
                            color: widget.juice.color,
                            onIncreaseClicked: () {
                              setState(() {
                                count++;
                              });
                            },
                            onDecreaseClicked: () {
                              setState(() {
                                if (count != 0) count--;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 58),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.juice.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SimpleRatingStar(),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Descripción de ${widget.juice.name}',
                      style: TextStyle(color: Color(0xFFB0B1B4), fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reviews',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            color: Color(0xFFD81C33),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ReviewList(),
                  ],
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
          Container(
            color: widget.juice.color,
            padding: EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back, size: 32, color: Colors.white),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Cherry´s Café",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 32,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleRatingStar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(Icons.star, color: Color(0xFFF3BE39), size: 18),
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, index) => SizedBox(width: 18),
        itemBuilder: (_, index) {
          return Image.asset("assets/challenge/juice1.png");
        },
        itemCount: 5,
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
      image: "assets/challenge/juice1.png",
      price: "15 pesitos",
      color: Color(0xFFF3BE39),
    ),
    JuiceEntity(
      name: "Juguito de naranja",
      image: "assets/challenge/juice2.png",
      price: "10 pesitos",
      color: Color(0xFFDC691F),
    ),
    JuiceEntity(
      name: "Juguito X",
      image: "assets/challenge/juice1.png",
      price: "50 pesitos",
      color: Color(0xFFF3BE39),
    ),
    JuiceEntity(
      name: "Juguito de naranja",
      image: "assets/challenge/juice2.png",
      price: "10 pesitos",
      color: Color(0xFFDC691F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Cherry´s Café",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                leading: Icon(Icons.menu, color: Colors.black, size: 32),
                actions: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                    size: 32,
                  ),
                  SizedBox(width: 12),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: JuiceWidget(juiceList[index]),
                  );
                }, childCount: juiceList.length),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                child: Container(
                  height: 64,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  color: Colors.white.withOpacity(.75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.home, size: 32),
                      Icon(Icons.search, size: 32),
                      Icon(Icons.favorite, size: 32),
                      Icon(Icons.account_circle_rounded, size: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

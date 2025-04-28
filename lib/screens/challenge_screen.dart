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
          final imageWidth = constraints.maxWidth * 0.6;
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
                            style:
                                juice.name == "Malteada de coco"
                                    ? textStyle.copyWith(
                                      fontSize: 20,
                                      color: Colors.black,
                                    )
                                    : textStyle.copyWith(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "\$",
                                  style: textStyle.copyWith(
                                    fontSize: 16,
                                    color:
                                        juice.name == "Malteada de coco"
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: juice.price.toString(),
                                  style: textStyle.copyWith(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        juice.name == "Malteada de coco"
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 48,
                            width: 100,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    juice.name == "Malteada de coco"
                                        ? Colors.black
                                        : Colors.white,
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
                              child: Text(
                                "detalles",
                                style: textStyle.copyWith(
                                  color: juice.color,
                                  fontSize: 20,
                                ),
                              ),
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
            child: Icon(
              Icons.remove,
              color: color == Color(0xFFf4f2ea) ? Colors.black : Colors.white,
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 30,
            child: Text(
              currentCount.toString(),
              style: txtstyle.copyWith(
                color: color == Color(0xFFf4f2ea) ? Colors.black : Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: onIncreaseClicked,
            child: Icon(
              Icons.add,
              color: color == Color(0xFFf4f2ea) ? Colors.black : Colors.white,
            ),
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
  var total = 0.00;
  @override
  Widget build(BuildContext context) {
    const topMargin = 40.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 100),
            children: [
              SizedBox(height: topMargin + 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  final imageHorizontalMargin = constraints.maxWidth * 0.15;
                  final imageHeight = constraints.maxHeight * 0.7;
                  return SizedBox(
                    height: 400,
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
                              child: Image.asset(
                                widget.juice.image,
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
                                total = count * widget.juice.price;
                              });
                            },
                            onDecreaseClicked: () {
                              setState(() {
                                if (count > 0) {
                                  count--;
                                  total -= widget.juice.price;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
                      'Descripción de ${widget.juice.name}:\nLa ${widget.juice.name} tiene ${widget.juice.name} en polvo, leche fresca y edulcorantes naturales.\nHecho completamente a mano.',
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
              SizedBox(height: 50),
            ],
          ),
          Container(
            color: widget.juice.color,
            padding: EdgeInsets.only(left: 24, right: 24, top: topMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color:
                        widget.juice.name == "Malteada de coco"
                            ? Colors.black
                            : Colors.white,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Cherry´s Café",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color:
                        widget.juice.name == "Malteada de coco"
                            ? Colors.black
                            : Colors.white,
                    fontFamily: "Miligant",
                  ),
                ),
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 32,
                  color:
                      widget.juice.name == "Malteada de coco"
                          ? Colors.black
                          : Colors.white,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '\$',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                count == 0
                                    ? 0.00.toStringAsFixed(2)
                                    : total.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 48,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: widget.juice.color,
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontFamily: "Arial",
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "comprar",
                        style:
                            widget.juice.name == "Malteada de coco"
                                ? textStyle.copyWith(
                                  fontSize: 20,
                                  color: Colors.black,
                                )
                                : textStyle.copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
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
          return Image.asset("assets/challenge/cliente5.png");
        },
        itemCount: 5,
      ),
    );
  }
}

class JuiceEntity {
  final String name;
  final String image;
  final double price;
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
      name: "Malteada de fresa",
      image: "assets/challenge/malteadaFresa.png",
      price: 15.99,
      color: Color(0xFFD02C2F),
    ),
    JuiceEntity(
      name: "Malteada de chocolate",
      image: "assets/challenge/malteadaChocolate.png",
      price: 10.99,
      color: Color(0xFF7d3719),
    ),
    JuiceEntity(
      name: "Malteada de mango",
      image: "assets/challenge/malteadaMango.png",
      price: 50.99,
      color: Color(0xFFe8ba38),
    ),
    JuiceEntity(
      name: "Malteada de coco",
      image: "assets/challenge/malteadaCoco.png",
      price: 100.99,
      color: Color(0xFFf4f2ea),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    fontFamily: "Miligant",
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

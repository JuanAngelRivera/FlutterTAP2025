import 'dart:ui';

import 'package:flutter/material.dart';

class JuiceWidget extends StatelessWidget {
  final JuiceEntity juice;

  const JuiceWidget(this.juice, {super.key});

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
                              onPressed: () {},
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
          // El contenido con scroll y el AppBar flotante
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  "Cherry´s Cafe",
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

          // Menú inferior con blur y transparencia real
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
                  color: Colors.white.withOpacity(
                    0.1,
                  ), // Asegúrate de que sea semitransparente
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

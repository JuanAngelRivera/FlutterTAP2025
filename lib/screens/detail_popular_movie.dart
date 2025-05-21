import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';

class DetailPopularMovie extends StatefulWidget {
  const DetailPopularMovie({super.key});

  @override
  State<DetailPopularMovie> createState() => _DetailPopularMovieState();
}

class _DetailPopularMovieState extends State<DetailPopularMovie> {
  final textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Arial',
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    final popularModel =
        ModalRoute.of(context)!.settings.arguments as PopularModel;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            snap: true,
            backgroundColor: Colors.purple,
            elevation: 0,
            title: Text(
              popularModel.title,
              style: textStyle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 32),
              onPressed: Navigator.of(context).pop,
            ),
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final percent =
                    (1 -
                        (constraints.maxHeight - kToolbarHeight) /
                            ((300 - kToolbarHeight).clamp(0.0, 1.0)));

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image(
                      image: NetworkImage(popularModel.posterPath),
                      fit: BoxFit.cover,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.white.withAlpha(percent.toInt()),
                            Colors.white.withAlpha(0),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            pinned: true,
          ),
          SliverList.list(children: [
            ],
          ),
        ],
      ),
    );
  }
}

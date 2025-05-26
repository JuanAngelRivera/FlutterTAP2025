import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';
import 'package:flutter_application/widgets/favorite_button_widget.dart';

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
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(popularModel.posterPath, fit: BoxFit.cover),
          ),

          CustomScrollView(
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
                pinned: true,
              ),

              SliverToBoxAdapter(
                child: Container(
                  height: 300,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      // Puedes hacer que el degradado siempre esté visible o animarlo con scroll si quieres
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.0),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverList.list(
                children: [SliverToBoxAdapter(child: Text("miau"))],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

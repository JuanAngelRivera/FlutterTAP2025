import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';

class DetailPopularMovie extends StatefulWidget {
  const DetailPopularMovie({super.key});

  @override
  State<DetailPopularMovie> createState() => _DetailPopularMovieState();
}

class _DetailPopularMovieState extends State<DetailPopularMovie> {
  @override
  Widget build(BuildContext context) {
    final popularModel =
        ModalRoute.of(context)!.settings.arguments as PopularModel;
    return Container();
  }
}

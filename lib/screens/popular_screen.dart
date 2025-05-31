import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';
import 'package:flutter_application/network/api_popular.dart';
import 'package:flutter_application/screens/challenge_screen.dart';
import 'package:flutter_application/widgets/itemPopularWidget.dart';
import 'package:flutter_application/utils/global_values.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;
  List<PopularModel>? popularMovies;

  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    popularMovies = await apiPopular!.getPopularMovies();
    setState(() {});
  }

  void _onFavoriteChanged(int movieId, bool isFavorite) {
    final index = popularMovies!.indexWhere((m) => m.id == movieId);
    if (index != -1) {
      setState(() {
        popularMovies![index].isFavorite = isFavorite;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Cherry Cinema",
          style: textStyle.copyWith(
            color: Colors.white,
            fontSize: 32,
            fontFamily: "Miligant",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, "/favorite");
              if (result == true) {
                await _loadMovies();
              }
            },
            icon: Icon(Icons.favorite, color: Colors.white, size: 24),
          ),
        ],
      ),
      body:
          popularMovies == null
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: popularMovies!.length,
                itemBuilder: (context, index) {
                  final movie = popularMovies![index];
                  return ItemPopularWidget(
                    key: ValueKey(movie.id),
                    popularModel: movie,
                    onFavoriteChanged: (bool isFav) {
                      _onFavoriteChanged(movie.id, isFav);
                    },
                    isFavorite: movie.isFavorite ?? false,
                    botonEsquina: false,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
              ),
    );
  }
}

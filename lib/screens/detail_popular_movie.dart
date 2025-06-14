import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application/network/actor.dart';
import 'package:flutter_application/network/trailer.dart';
import 'package:flutter_application/utils/DetailScreenArguments.dart';
import 'package:flutter_application/widgets/ActorListWidget.dart';
import 'package:flutter_application/widgets/favoriteButtonWidget.dart';
import 'package:flutter_application/widgets/starRatingWidget.dart';

class DetailPopularMovie extends StatefulWidget {
  const DetailPopularMovie({super.key});

  @override
  State<DetailPopularMovie> createState() => _DetailPopularMovieState();
}

class _DetailPopularMovieState extends State<DetailPopularMovie> {
  late DetailScreenArguments detailScreenArguments;

  final textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Arial',
    fontWeight: FontWeight.normal,
  );

  final baseStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Arial',
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    detailScreenArguments =
        ModalRoute.of(context)!.settings.arguments as DetailScreenArguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [_buildSliverAppBar(), _buildMovieDetails()],
      ),
    );
  }

  /// SliverAppBar con imagen + botón de reproducción
  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      floating: true,
      snap: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      title: Text(
        detailScreenArguments.movie.title,
        style: textStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w800),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
        onPressed: () => Navigator.of(context).pop(),
      ),
      flexibleSpace: GestureDetector(
        onTap: _onVideoTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: detailScreenArguments.movie.id,
              child: FadeInImage(
                placeholder: NetworkImage(
                  detailScreenArguments.movie.backdropPath,
                ),
                image: NetworkImage(detailScreenArguments.movie.posterPath),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white.withAlpha(200),
                size: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildMovieDetails() {
    final movie = detailScreenArguments.movie;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    movie.title,
                    style: baseStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                    ),
                  ),
                ),
                FavoriteButtonWidget(
                  movieId: movie.id,
                  onFavoriteChanged: detailScreenArguments.onFavoriteChanged!,
                  isFavorite: movie.isFavorite,
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 5),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Información de la película",
                style: baseStyle.copyWith(fontWeight: FontWeight.w900),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 10),
            Divider(thickness: 5),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text.rich(
                  TextSpan(
                    style: baseStyle,
                    children: [
                      TextSpan(
                        text: 'Título original: ',
                        style: baseStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '${movie.originalTitle}\n\n'),
                      TextSpan(
                        text: 'Lenguaje original: ',
                        style: baseStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${movie.originalLanguage.toUpperCase()}\n\n',
                      ),
                      TextSpan(
                        text: 'Estreno: ',
                        style: baseStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${movie.releaseDate}\n\n',
                        style: baseStyle.copyWith(height: 0.5),
                      ),
                    ],
                  ),
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToLastDescent: false,
                    applyHeightToFirstAscent: false,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Calificación: ',
                        style: baseStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    StarRatingWidget(
                      puntuacion: detailScreenArguments.movie.voteAverage,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 5),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    style: baseStyle,
                    children: [
                      TextSpan(
                        text: 'Sinopsis:\n',
                        style: baseStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  movie.overview,
                  textAlign: TextAlign.justify,
                  style: baseStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(thickness: 5),
            SizedBox(height: 10),
            Text(
              "Actores de reparto",
              style: baseStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<Actor>>(
              future: fetchMovieActors(movie.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Error al cargar el reparto'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text('No se encontraron actores'),
                  );
                }
                return ActorListWidget(actores: snapshot.data!);
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Acción al tocar la imagen para ver el video
  Future<void> _onVideoTap() async {
    final videoKey = await fetchTrailerVideoKey(detailScreenArguments.movie.id);
    if (videoKey != null) {
      await openYoutubeVideo(videoKey);
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se encontró trailer')));
    }
  }
}

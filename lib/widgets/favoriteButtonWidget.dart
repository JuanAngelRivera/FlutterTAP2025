import 'package:flutter/material.dart';
import 'package:flutter_application/network/favorite.dart';
import 'package:flutter_application/network/tMDBAuth.dart';
import 'package:flutter_application/utils/global_values.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({super.key, required this.movieId});

  final int movieId;

  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final favorite = Favorite();
    bool isFavorite = false;
    return IconButton.filled(
      onPressed: () async {
        final sessionId = GlobalValues.sessionId;
        if (sessionId == null) {
          final res = await Navigator.pushNamed(
            context,
            "/sesion",
            arguments: widget.movieId,
          );
          if (res != null && GlobalValues.sessionId != null) {
            favorite.marcarFavorito(
              movieId: widget.movieId,
              sessionId: GlobalValues.sessionId,
              context: context,
            );
            return;
          }
        }

        await favorite.cambiarFavorito(
          context,
          widget.movieId,
          !isFavorite,
          GlobalValues.sessionId!,
        );
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(Icons.favorite, color: Colors.purple, size: 32),
      color: Colors.white,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
    );
  }
}

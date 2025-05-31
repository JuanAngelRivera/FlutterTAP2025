import 'package:flutter/material.dart';
import 'package:flutter_application/network/favorite.dart';
import 'package:flutter_application/utils/global_values.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({
    super.key,
    required this.movieId,
    required this.onFavoriteChanged,
  });

  final int movieId;
  final VoidCallback? onFavoriteChanged;
  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  final favorite = Favorite();
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _verificarFavorito();
  }

  Future<void> _verificarFavorito() async {
    final sessionId = GlobalValues.sessionId;
    if (sessionId != null) {
      final esta = await favorite.estaEnFavoritos(widget.movieId, sessionId);
      setState(() {
        isFavorite = esta;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            await favorite.marcarFavorito(
              movieId: widget.movieId,
              sessionId: GlobalValues.sessionId!,
              context: context,
            );
            setState(() {
              isFavorite = true;
            });
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
        if (widget.onFavoriteChanged != null) {
          widget.onFavoriteChanged!();
        }
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.purple : Colors.grey,
        size: 32,
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
      ),
    );
  }
}

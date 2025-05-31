import 'package:flutter/material.dart';
import 'package:flutter_application/network/favorite.dart';
import 'package:flutter_application/utils/global_values.dart';

class FavoriteButtonWidget extends StatefulWidget {
  const FavoriteButtonWidget({
    super.key,
    required this.movieId,
    required this.onFavoriteChanged,
    required this.isFavorite,
  });

  final int movieId;
  final bool isFavorite;
  final ValueChanged<bool> onFavoriteChanged;
  @override
  State<FavoriteButtonWidget> createState() => _FavoriteButtonWidgetState();
}

class _FavoriteButtonWidgetState extends State<FavoriteButtonWidget> {
  final favorite = Favorite();
  late bool isFavorite = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
    _verificarFavorito();
  }

  @override
  void didUpdateWidget(covariant FavoriteButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isFavorite != widget.isFavorite) {
      isFavorite = widget.isFavorite;
    }
  }

  _toggleFavorite() async {
    await favorite.cambiarFavorito(
      context,
      widget.movieId,
      !isFavorite,
      GlobalValues.sessionId!,
    );

    setState(() {
      isFavorite = !isFavorite;
      _isLoading = false;
    });
    widget.onFavoriteChanged(isFavorite);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (GlobalValues.sessionId != null && !isFavorite) {
      _verificarFavorito();
    }
  }

  Future<void> _verificarFavorito() async {
    final sessionId = GlobalValues.sessionId;
    if (sessionId != null) {
      final esta = await favorite.estaEnFavoritos(widget.movieId, sessionId);
      if (!mounted) return;
      setState(() {
        isFavorite = esta;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(strokeWidth: 3),
        )
        : IconButton.filled(
          onPressed: () async {
            final sessionId = GlobalValues.sessionId;

            setState(() {
              _isLoading = true;
            });

            if (sessionId == null) {
              final res = await Navigator.pushNamed(
                context,
                "/sesion",
                arguments: widget.movieId,
              );
              if (res != false && GlobalValues.sessionId != null) {
                await favorite.marcarFavorito(
                  movieId: widget.movieId,
                  sessionId: GlobalValues.sessionId!,
                  context: context,
                );
                setState(() {
                  isFavorite = true;
                  _isLoading = false;
                });
                widget.onFavoriteChanged(isFavorite);
                return;
              } else {
                setState(() {
                  _isLoading = false;
                });
                return;
              }
            } else {
              await _toggleFavorite();
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

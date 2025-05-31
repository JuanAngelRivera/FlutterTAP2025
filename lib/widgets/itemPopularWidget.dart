import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';
import 'package:flutter_application/utils/DetailScreenArguments.dart';
import 'package:flutter_application/widgets/favoriteButtonWidget.dart';

class ItemPopularWidget extends StatelessWidget {
  const ItemPopularWidget({
    super.key,
    required this.popularModel,
    required this.isFavorite,
    required this.onFavoriteChanged,
    this.botonEsquina = true, // Valor por defecto activado
  });

  final PopularModel popularModel;
  final ValueChanged<bool> onFavoriteChanged;
  final bool isFavorite;
  final bool botonEsquina;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(popularModel.backdropPath),
          ),
          Container(
            color: Colors.purple,
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: Text(
                popularModel.title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(Icons.arrow_right, size: 50, color: Colors.white),
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: DetailScreenArguments(
                      movie: popularModel,
                      onFavoriteChanged: onFavoriteChanged,
                    ),
                  ),
            ),
          ),
          if (botonEsquina)
            Positioned(
              top: 10,
              right: 10,
              child: FavoriteButtonWidget(
                movieId: popularModel.id,
                onFavoriteChanged: onFavoriteChanged,
                isFavorite: isFavorite,
              ),
            ),
        ],
      ),
    );
  }
}

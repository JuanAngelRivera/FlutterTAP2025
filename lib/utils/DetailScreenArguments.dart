import 'package:flutter_application/models/popular_model.dart';

class DetailScreenArguments {
  final PopularModel movie;
  final void Function()? onFavoriteChanged;

  DetailScreenArguments({required this.movie, this.onFavoriteChanged});
}

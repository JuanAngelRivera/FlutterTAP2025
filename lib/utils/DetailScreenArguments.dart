import 'package:flutter/widgets.dart';
import 'package:flutter_application/models/popular_model.dart';

class DetailScreenArguments {
  final PopularModel movie;
  final ValueChanged<bool>? onFavoriteChanged;

  DetailScreenArguments({required this.movie, this.onFavoriteChanged});
}

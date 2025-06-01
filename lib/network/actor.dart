import 'package:dio/dio.dart';

class Actor {
  final int id;
  final String name;
  final String profilePath;

  Actor({required this.id, required this.name, required this.profilePath});

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      profilePath:
          json['profile_path'] != null
              ? 'https://image.tmdb.org/t/p/w185${json['profile_path']}'
              : '',
    );
  }
}

Future<List<Actor>> fetchMovieActors(int movieId) async {
  final dio = Dio();
  const apiKey = "44c54bf05c862d4a1d678b17613692cb";
  final url =
      'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=es-MX';

  try {
    final response = await dio.get(url);
    final castList = response.data['cast'] as List;

    return castList
        .map((actorData) => Actor.fromJson(actorData))
        .take(10)
        .toList();
  } catch (e) {
    print('Error al obtener actores: $e');
    return [];
  }
}

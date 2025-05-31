import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';

class Favorite {
  final String URL = 'https://api.themoviedb.org/3/account/210924/favorite';
  final String apiKey = "44c54bf05c862d4a1d678b17613692cb";
  final dio = Dio();

  Future<void> marcarFavorito({
    required movieId,
    required sessionId,
    required context,
  }) async {
    final response = await dio.post(
      URL,
      queryParameters: {'api_key': apiKey, 'session_id': sessionId},
      data: {"media_type": "movie", "media_id": movieId, "favorite": true},
      options: Options(
        headers: {'Content-Type': 'application/json;charset=utf-8'},
      ),
    );

    if (response.statusCode == 201) {
      print("✅ Pelicula registrada correctamente|MarcarFavorito");

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Película agregada a favoritos!'),
          duration: Duration(seconds: 3),
          padding: EdgeInsets.all(10),
        ),
      );
    } else {
      print("⚠️ Error al marcar favorita: ${response.statusCode}");
      print(response.data);
    }
  }

  Future<bool> estaEnFavoritos(int movieId, String sessionId) async {
    final dio = Dio();
    final response = await dio.get(
      'https://api.themoviedb.org/3/account/{account_id}/favorite/movies',
      queryParameters: {
        'api_key': apiKey,
        'session_id': sessionId,
        'language': 'es-MX',
        'page': 1,
      },
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.any((movie) => movie['id'] == movieId);
    } else {
      throw Exception('Error obteniendo favoritos');
    }
  }

  Future<void> cambiarFavorito(
    BuildContext context,
    int movieId,
    bool marcar,
    String sessionId,
  ) async {
    try {
      final response = await dio.post(
        'https://api.themoviedb.org/3/account/{account_id}/favorite',
        queryParameters: {'api_key': apiKey, 'session_id': sessionId},
        data: {
          "media_type": "movie",
          "media_id": movieId,
          "favorite": marcar, // true para marcar, false para desmarcar
        },
        options: Options(
          headers: {'Content-Type': 'application/json;charset=utf-8'},
        ),
      );

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              marcar
                  ? '🎉 Película agregada a favoritos!'
                  : '❌ Película removida de favoritos!',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('⚠️ Error al actualizar favoritos')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ Error: $e')));
    }
  }

  Future<List<dynamic>> obtenerFavoritos(String sessionId) async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/account/{account_id}/favorite/movies',
        queryParameters: {'api_key': apiKey, 'session_id': sessionId},
      );

      if (response.statusCode == 200) {
        final data = response.data['results'] as List;
        print(data);
        return data
            .map((movie) => PopularModel.fromMap(movie))
            .toList(); // Lista de películas favoritas
      } else {
        print('❌ Error al obtener favoritos: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Excepción al obtener favoritos: $e');
    }
    return [];
  }
}

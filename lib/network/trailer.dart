import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String?> fetchTrailerVideoKey(int movieId) async {
  final dio = Dio();
  const apiKey = '44c54bf05c862d4a1d678b17613692cb';
  const language = 'es-MX';

  final url = 'https://api.themoviedb.org/3/movie/$movieId/videos';

  try {
    final response = await dio.get(
      url,
      queryParameters: {'api_key': apiKey, 'language': language},
    );

    final results = response.data['results'] as List;

    final trailer = results.firstWhere(
      (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
      orElse: () => null,
    );

    if (trailer != null) {
      return trailer['key'];
    } else {
      return null;
    }
  } catch (e) {
    print('Error al obtener el video: $e');
    return null;
  }
}

Future<void> openYoutubeVideo(String videoKey) async {
  final appUrl = Uri.parse('https://www.youtube.com/watch?v=$videoKey');

  if (!await launchUrl(appUrl, mode: LaunchMode.externalApplication)) {
    print("❌ No se pudo abrir el navegador ${appUrl.toString()}");
  }
}

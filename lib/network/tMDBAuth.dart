// auth_service.dart
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class TMDBAuth {
  final String apiKey = "44c54bf05c862d4a1d678b17613692cb";
  final dio = Dio();

  Future<String?> getRequestToken() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://api.themoviedb.org/3/authentication/token/new',
        queryParameters: {'api_key': apiKey},
      );
      print("📦 Respuesta: ${response.data}");

      if (response.statusCode == 200) {
        return response.data['request_token'];
      } else {
        print('❌ Error: ${response.statusCode}');
        print(response.data);
      }
    } catch (e) {
      print('❌ Excepción: $e');
    }

    return null;
  }

  Future<void> abrirNavegadorParaAutorizar(String requestToken) async {
    final url = Uri.parse(
      'https://www.themoviedb.org/authenticate/$requestToken',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      print("❌ No se pudo abrir el navegador");
    }
  }

  Future<String?> crearSession(String requestToken) async {
    try {
      final response = await dio.post(
        'https://api.themoviedb.org/3/authentication/session/new',
        queryParameters: {'api_key': apiKey},
        data: {'request_token': requestToken},
      );
      final sessionId = response.data['session_id'];
      print("✅ Session creada: $sessionId");
      return sessionId;
    } catch (e) {
      print("❌ Error al crear sesión: $e");
      return null;
    }
  }
}

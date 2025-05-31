import 'package:flutter/material.dart';
import 'package:flutter_application/network/favorite.dart';
import 'package:flutter_application/network/tMDBAuth.dart';
import 'package:flutter_application/utils/global_values.dart';

class LoginTMDBPage extends StatefulWidget {
  @override
  _LoginTMDBPageState createState() => _LoginTMDBPageState();
}

class _LoginTMDBPageState extends State<LoginTMDBPage> {
  final auth = TMDBAuth();

  String? requestToken;
  bool autorizado = false;
  String? sessionId;

  // Paso 1: Pedir token y abrir navegador
  Future<void> iniciarAutorizacion() async {
    final token = await auth.getRequestToken();
    if (token != null) {
      setState(() {
        requestToken = token;
      });
      await auth.abrirNavegadorParaAutorizar(token);
      // Aquí el usuario se va al navegador, debe autorizar y volver
    }
  }

  // Paso 2: Crear sesión con token autorizado
  Future<void> confirmarAutorizacion(movieId) async {
    if (requestToken == null) return;

    final sId = await auth.crearSession(requestToken!);
    if (sId != null) {
      setState(() {
        sessionId = sId;
        autorizado = true;
      });
      GlobalValues.sessionId = sId;
      print("🎉 Sesión creada: $sId");
      Navigator.pop(context, true);
    } else {
      print("Error al crear sesión");
    }
  }

  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(title: Text("Login TMDB")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: iniciarAutorizacion,
              child: Text("Iniciar autorización"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  autorizado
                      ? null
                      : () {
                        confirmarAutorizacion(movieId);
                      },
              child: Text("Confirmar autorización"),
            ),
            SizedBox(height: 32),
            if (sessionId != null) Text("Session ID:\n$sessionId"),
          ],
        ),
      ),
    );
  }
}

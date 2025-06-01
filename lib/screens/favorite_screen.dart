import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';
import 'package:flutter_application/network/api_popular.dart';
import 'package:flutter_application/network/favorite.dart';
import 'package:flutter_application/screens/challenge_screen.dart';
import 'package:flutter_application/utils/global_values.dart';
import 'package:flutter_application/widgets/itemPopularWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Favorite? favorite;
  @override
  void initState() {
    super.initState();
    favorite = Favorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Favoritos",
          style: textStyle.copyWith(color: Colors.white, fontSize: 32),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ),
      body:
          GlobalValues.sessionId == null
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No tienes películas marcadas como favoritas.\nDa clic en el siguiente botón para iniciar sesión:",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.pushNamed(
                          context,
                          "/sesion",
                          arguments: 0,
                        );
                        if (result != null) {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('🎉 Sesión Iniciada!')),
                            );
                          });
                        }
                      },

                      child: Text("INICIAR SESION"),
                    ),
                  ],
                ),
              )
              : FutureBuilder(
                future: favorite!.obtenerFavoritos(GlobalValues.sessionId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "No tienes películas marcadas como favoritas.",
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final movie = snapshot.data![index];
                        return ItemPopularWidget(
                          key: ValueKey(movie.id),
                          popularModel: movie,
                          onFavoriteChanged: (nuevoEstado) {
                            if (!nuevoEstado) {
                              setState(() {});
                            }
                          },
                          isFavorite: true,
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Algo salió mal ${snapshot.error.toString()}',
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
    );
  }
}

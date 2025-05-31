import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';
import 'package:flutter_application/network/api_popular.dart';
import 'package:flutter_application/screens/challenge_screen.dart';
import 'package:flutter_application/widgets/itemPopularWidget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Cherry Cinema",
          style: textStyle.copyWith(
            color: Colors.white,
            fontSize: 32,
            fontFamily: "Miligant",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/favorite"),
            icon: Icon(Icons.favorite, color: Colors.white, size: 24),
          ),
        ],
      ),
      body: FutureBuilder(
        future: apiPopular!.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ItemPopularWidget(
                  popularModel: snapshot.data![index],
                  onFavoriteChanged: null,
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Algo salió mal ${snapshot.error.toString()}'),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

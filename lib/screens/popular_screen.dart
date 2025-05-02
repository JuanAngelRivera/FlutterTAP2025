import 'package:flutter/material.dart';
import 'package:flutter_application/models/popular_model.dart';
import 'package:flutter_application/network/api_popular.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
    //apiPopular!.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: apiPopular!.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return itemPopular(snapshot.data![index]);
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

  Widget itemPopular(PopularModel popularModel) {
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
            color: Colors.black,
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: Text(
                popularModel.title,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(
                Icons.chevron_right,
                size: 50,
                color: Colors.white,
              ),
              onTap:
                  () => Navigator.pushNamed(
                    context,
                    '/detail',
                    arguments: popularModel,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

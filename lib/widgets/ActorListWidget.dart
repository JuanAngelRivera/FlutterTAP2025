import 'package:flutter/material.dart';
import 'package:flutter_application/network/actor.dart';

class ActorListWidget extends StatelessWidget {
  final List<Actor> actores;
  const ActorListWidget({super.key, required this.actores});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, index) => SizedBox(width: 5),
        itemCount: actores.length,
        itemBuilder: (_, index) {
          final actor = actores[index];
          return Column(
            children: [
              SizedBox(
                width: 100,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child:
                          actor.profilePath.isNotEmpty
                              ? Image.network(
                                actor.profilePath,
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              )
                              : Icon(Icons.person, size: 90),
                    ),
                    SizedBox(height: 5),
                    Text(
                      actor.name,
                      style: TextStyle(fontSize: 12),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

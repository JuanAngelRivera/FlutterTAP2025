import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Arial',
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: Text("Favoritas", style: textStyle.copyWith(fontSize: 32)),
        centerTitle: true,
      ),
      body: Text("nya"),
    );
  }
}

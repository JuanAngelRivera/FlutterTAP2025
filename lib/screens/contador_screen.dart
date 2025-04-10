import 'package:flutter/material.dart';

class ContadorScreen extends StatefulWidget {
  ContadorScreen({super.key});

  @override
  State<ContadorScreen> createState() => _ContadorScreenState();
}

class _ContadorScreenState extends State<ContadorScreen> {
  var contador = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mi primera app", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "Valor del contador $contador",
          style: TextStyle(fontSize: 25, color: Colors.amber),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          contador++;
          setState(() {});
        },
      ),
    );
  }
}

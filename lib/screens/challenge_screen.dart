import 'package:flutter/material.dart';

class ChallengeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Challenge")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: JuiceWidget(),
        ),
      ),
    );
  }
}

class JuiceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.25,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFDC691F),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          Row(
            children: [
              Expanded(child: Placeholder()),
              SizedBox(
                width: 120,
                child: Image.asset('assets/challenge/juice.png', width: 350),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

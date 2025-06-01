import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double puntuacion;
  StarRatingWidget({super.key, required this.puntuacion});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(10, (index) {
          return Icon(
            index < puntuacion.toInt() ? Icons.star : Icons.star_border,
            color: const Color(0xFFF3BE39),
            size: 18,
          );
        }),

        Text("(${puntuacion})"),
      ],
    );
  }
}

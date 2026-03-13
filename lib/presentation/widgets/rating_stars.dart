import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final halfStar = (rating - fullStars) >= 0.5;
    return Row(
      children: List<Widget>.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, size: 14, color: Colors.orange);
        } else if (index == fullStars && halfStar) {
          return const Icon(Icons.star_half, size: 14, color: Colors.orange);
        } else {
          return const Icon(Icons.star_border, size: 14, color: Colors.orange);
        }
      }),
    );
  }
}



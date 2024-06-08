import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String icon;
  final double width;
  const ImageWidget({super.key, required this.icon, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
      child: Image.network(
        'http:$icon',
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      ),
    );
  }
}

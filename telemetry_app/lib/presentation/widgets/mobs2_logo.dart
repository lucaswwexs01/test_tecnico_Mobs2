import 'package:flutter/material.dart';

class Mobs2Logo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;

  const Mobs2Logo({
    super.key,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: width ?? 120,
      height: height ?? 40,
      fit: fit ?? BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        // Se a imagem não carregar, mostra um placeholder
        return Container(
          width: width ?? 120,
          height: height ?? 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'MOBS2',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
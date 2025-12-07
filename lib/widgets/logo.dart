import 'package:flutter/material.dart';

class LogoFAB extends StatelessWidget {
  final String imagePath;
  final double size;
  final double haloSize;
  final bool active;
  const LogoFAB({required this.imagePath, this.size = 64, this.haloSize = 100, this.active = true, super.key});

  @override
  Widget build(BuildContext context) {
    final Color glow = const Color.fromARGB(255, 126, 82, 193);
    final Color ring = const Color(0xFF6E44AD);

    return SizedBox(
      width: haloSize,
      height: haloSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: haloSize,
            height: haloSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [glow.withOpacity(active ? 0.35 : 0.22), Colors.transparent], stops: const [0.0, 1.0]),
            ),
          ),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6E44AD), Color(0xFF4A2C88)],
              ),
              boxShadow: [BoxShadow(color: glow.withOpacity(active ? 0.45 : 0.25), blurRadius: 24, spreadRadius: 2)],
              border: Border.all(color: ring.withOpacity(0.85), width: 2),
            ),
            child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}

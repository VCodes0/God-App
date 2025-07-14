import 'package:flutter/material.dart';

class TopLeftPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;

    final double radius = size.width * 0.4;
    final Offset center = Offset(size.width * 0.2, size.height * 0.2);

    canvas.drawCircle(center, radius, paint);

    paint.color = Colors.white.withValues(alpha: 0.5);
    canvas.drawCircle(center.translate(radius * 0.5, 0), radius * 0.3, paint);
    canvas.drawCircle(center.translate(-radius * 0.5, 0), radius * 0.3, paint);
    canvas.drawCircle(center.translate(0, radius * 0.5), radius * 0.3, paint);
    canvas.drawCircle(center.translate(0, -radius * 0.5), radius * 0.3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SelectionCard extends StatelessWidget {
  final VoidCallback onTap;
  final String? cardTitle;
  final IconData? cardIcon;

  const SelectionCard({
    super.key,
    required this.onTap,
    this.cardTitle,
    this.cardIcon,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final double cardWidth = mq.width * 0.4;
    final double cardHeight = mq.height * 0.25;
    final double iconSize = mq.width * 0.08;
    final double fontSize = mq.width * 0.045;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.transparent, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gradient border background
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF7A00), Color(0xFFFF0000)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                ),
              ),
            ),

            // Decorative painter
            Positioned(
              top: 10,
              left: 10,
              child: SizedBox(
                width: cardWidth * 0.3,
                height: cardWidth * 0.3,
                child: CustomPaint(painter: TopLeftPatternPainter()),
              ),
            ),

            // Icon & Title
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cardIcon ?? Icons.waving_hand,
                    size: iconSize,
                    color: const Color(0xFFFF7A00),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cardTitle ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFF7A00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NowMinInfoWidget extends StatelessWidget {
  const NowMinInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mostly cloudy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.circle, color: Colors.white, size: 100),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(
                  '18°',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Feels like 17°',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

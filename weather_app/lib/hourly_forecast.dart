import 'package:flutter/material.dart';

class HourlyForecastWidget extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temparature;
  const HourlyForecastWidget(
      {super.key,
      required this.icon,
      required this.time,
      required this.temparature});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(
              height: 8,
            ),
            Icon(
              icon,
              size: 25,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              temparature,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

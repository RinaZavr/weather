import 'package:flutter/material.dart';

class AfternoonWidget extends StatefulWidget {
  final double max;
  final List<double> values;
  const AfternoonWidget({super.key, required this.max, required this.values});

  @override
  State<AfternoonWidget> createState() => _AfternoonWidgetState();
}

class _AfternoonWidgetState extends State<AfternoonWidget> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: widget.max * 3,
                  maxWidth: MediaQuery.of(context).size.width / 8 - 2,
                ),
                child: Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: EdgeInsets.only(top: 4),
                  height: widget.values[index] * 3,
                  decoration: BoxDecoration(
                    color: Colors.yellow[300],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    '${widget.values[index].toStringAsFixed(0)}°',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Text(
                '$index pm',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              const Icon(
                Icons.circle, color: Colors.white, size: 35,
              ),
            ],
          );
        },
        itemCount: 8,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

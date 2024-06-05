import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeekWidget extends StatefulWidget {
  final double maxVal;
  final double maxPer;
  final List<double> values;
  final List<double> valuesMin;
  final List<double> valuesPer;
  const WeekWidget({
    super.key,
    required this.maxVal,
    required this.maxPer,
    required this.values,
    required this.valuesMin,
    required this.valuesPer,
  });

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 350),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2 - 45),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    height: 300 / 8,
                    width: widget.valuesPer[index] + 38,
                    decoration: BoxDecoration(
                      color: Colors.yellow[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.valuesPer[index].toStringAsFixed(0)}%',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(Icons.circle, color: Colors.white, size: 30),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 45,
                child: Column(
                  children: [
                    Text(
                      'WED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '5',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2 - 45),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    height: 300 / 8,
                    width: widget.values[index] * 3 + 38,
                    decoration: BoxDecoration(
                      color: Colors.yellow[300],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          color: Colors.yellow[600],
                          height: 300 / 8,
                          width: 30,
                          child: Text(
                            '${widget.valuesMin[index].toStringAsFixed(0)}°',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            '${widget.values[index].toStringAsFixed(0)}°',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
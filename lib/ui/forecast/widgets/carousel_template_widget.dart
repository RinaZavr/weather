import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class CarouselTemplateWidget extends StatefulWidget {
  final String title;
  final String description;
  final Widget firstWidget;
  final Widget secondWidget;
  const CarouselTemplateWidget({
    super.key,
    required this.title,
    required this.description,
    required this.firstWidget,
    required this.secondWidget,
  });

  @override
  State<CarouselTemplateWidget> createState() => _CarouselTemplateWidgetState();
}

class _CarouselTemplateWidgetState extends State<CarouselTemplateWidget> {
  int curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (widget.description.isNotEmpty)
          Text(
            widget.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ExpandablePageView(
          onPageChanged: (value) => setState(() => curIndex = value),
          children: [
            widget.firstWidget,
            widget.secondWidget,
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 2; i++)
              Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: curIndex == i
                      ? const Color.fromARGB(255, 77, 77, 77)
                      : const Color.fromARGB(255, 46, 46, 46),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weather/domain/models/current_day_model.dart';
import 'package:weather/ui/location/screens/location_screen.dart';
import 'package:weather/utils/consts/color_consts.dart';

class LocationWidget extends StatefulWidget {
  final CurrentDay currentDay;
  const LocationWidget({super.key, required this.currentDay});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 100),
          barrierColor: Colors.black.withOpacity(0.8),
          context: context,
          builder: (context) => const LocationScreen(),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 4,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.yellow,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.currentDay.location.country}, ${widget.currentDay.location.name}',
              style: const TextStyle(
                color: AppColors.yellow,
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            GestureDetector(
              onTap: () {
                Share.share('${widget.currentDay.location.name}: Сегодня ${widget.currentDay.tempC.toInt()}°C');
              },
              child: const Icon(
                Icons.ios_share_outlined,
                color: AppColors.yellow,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

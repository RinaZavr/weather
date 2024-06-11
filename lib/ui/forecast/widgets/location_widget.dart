import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/domain/models/current_day_model.dart';
import 'package:weather/ui/location/screens/location_screen.dart';

class LocationWidget extends StatefulWidget {
  final CurrentDay currentDay;
  const LocationWidget({
    super.key,
    required this.currentDay,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 200),
          isScrollControlled: true,
          context: context,
          builder: (context) => const LocationScreen(),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 4,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ThemeProvider.controllerOf(context).theme.data.primaryColorLight,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.currentDay.location.country}, ${widget.currentDay.location.name}',
              style: ThemeProvider.controllerOf(context)
                  .theme
                  .data
                  .textTheme
                  .displaySmall,
              overflow: TextOverflow.ellipsis,
            ),
            GestureDetector(
              onTap: () {
                Share.share(
                    '${widget.currentDay.location.name}: Right now ${widget.currentDay.temp.toInt()}°C');
              },
              child: Icon(
                Icons.ios_share_outlined,
                color: ThemeProvider.controllerOf(context).theme.data.primaryColorLight,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

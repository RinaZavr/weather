import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/domain/services/location_service.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4,),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.yellow,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            GetIt.instance.get<LocationService>().locationData.toString(),
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.ios_share_outlined,
              color: Colors.yellow,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}

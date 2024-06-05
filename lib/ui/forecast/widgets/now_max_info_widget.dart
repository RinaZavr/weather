import 'package:flutter/material.dart';

class NowMaxInfoWidget extends StatelessWidget {
  const NowMaxInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Icon(Icons.circle, color: Colors.white, size: 25,),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'lalalalalal lalalallala lalalalla lalalala lalalalalal lalalallala lalalalla lalalala',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 5,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:thirdeyesmanagement/modal/page_view_data.dart';

class SlideItem extends StatelessWidget {
  final int index;

  const SlideItem(this.index, {super.key});

  final Duration initialDelay = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(slideList[index].image,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                slideList[index].title,
                style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                slideList[index].description,
                style: const TextStyle(
                  fontFamily: "Dosis",
                  fontSize: 18,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class RealtimeCard extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  const RealtimeCard({
    Key? key,
    required this.img,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        // color: const Color(0xffF4E6BE),
        boxShadow: const [
          BoxShadow(
            offset: Offset(10, 16),
            blurRadius: 15,
            spreadRadius: -20,
          )
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            height: 40,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          Text(
            subTitle,
            style: const TextStyle(fontSize: 20, color: Colors.black87),
          )
        ],
      ),
    );
  }
}

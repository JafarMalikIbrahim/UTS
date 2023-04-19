import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  const StatusCard({
    Key? key,
    required this.img,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (contex) => ReadingStatusPage()));
      },
      child: Container(
        height: 500,
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
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            Text(
              subTitle,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

Widget AppText(
    {FontWeight isBold = FontWeight.normal,
    Color color = Colors.black,
    required double size,
    required String text,
    int maxLines = 0,
    bool overflow = false,
    bool alignCenter = false}) {
  return Text(
    text,
    textAlign: alignCenter == true ? TextAlign.center : null,
    maxLines: maxLines == 0 ? null : maxLines,
    overflow: overflow == true ? TextOverflow.ellipsis : null,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: isBold,
    ),
  );
}

Widget StarWidget(int active) {
  final children = <Widget>[];
  for (var i = 1; i <= 5; i++) {
    if (active <= 5 && active >= 0) {
      children.add(
        const Padding(
          padding: EdgeInsets.only(right: 2),
          child: Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
      );
    }
  }
  return Row(
    children: children,
  );
}

Widget ProductWidget(
    {String? time,
    String? name,
    int? rating,
    double width = 154,
    String? imgurl}) {
  return Container(
    width: width,
    height: 215,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(imgurl ?? 'https://picsum.photos/200/300'),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Container(
      padding: const EdgeInsets.only(left: 12, top: 18, right: 12, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: LinearGradient(
          colors: [
            const Color(0xff8D8D8D).withOpacity(0),
            Colors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.timelapse, color: Colors.white.withOpacity(.6)),
              const SizedBox(
                width: 4,
              ),
              AppText(
                size: 15,
                isBold: FontWeight.w500,
                text: time ?? '',
                color: Colors.white.withOpacity(.9),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                maxLines: 2,
                overflow: true,
                text: name ?? '',
                color: Colors.white,
                size: 16,
                isBold: FontWeight.bold,
              ),
              const SizedBox(
                height: 4,
              ),
              StarWidget(rating ?? 4),
            ],
          )
        ],
      ),
    ),
  );
}

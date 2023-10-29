import 'package:flutter/material.dart';

class CurvedImage extends StatelessWidget {
  CurvedImage({super.key, required this.imageUrl, required this.callback});
  String imageUrl;
  Function callback = () {};

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
          width: 100,
          height: 80,
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(imageUrl)),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            color: Colors.transparent,
          ),
        ));
  }
}

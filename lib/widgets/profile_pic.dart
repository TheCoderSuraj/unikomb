import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
    // required this.url,
    this.radius = 80,
    this.outsideRadius = 4,
    this.color = Colors.lightBlue,
    required this.image,
  }) : super(key: key);
  // final String url;
  final double radius;
  final double outsideRadius;
  final Color color;
  final ImageProvider<Object> image;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: radius + outsideRadius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image(
          image: image,
          fit: BoxFit.cover,
          height: radius * 2,
        ),
      ),
    );
  }
}

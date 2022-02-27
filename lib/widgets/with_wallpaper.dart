import 'package:flutter/material.dart';

class WithWallpaper extends StatelessWidget {
  const WithWallpaper({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/and.jpg'), fit: BoxFit.fill),
      ),
    );
  }
}

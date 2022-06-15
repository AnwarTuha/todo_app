import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({Key? key, required this.size, this.strokeWidth = 5})
      : super(key: key);

  final double size;
  final double strokeWidth;

  @override
  AppLoadingState createState() => AppLoadingState();
}

class AppLoadingState extends State<AppLoading> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Lottie.asset(
          'assets/lottie/loading.json',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

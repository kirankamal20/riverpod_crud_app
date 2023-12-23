import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomLoginElevatedButton extends StatelessWidget {
  final Function() login;
  final String label;
  final Widget? child;
  const CustomLoginElevatedButton(
      {super.key, required this.login, required this.label, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: login,
      child: child ?? label.text.white.bold.size(25).make(),
    ).h(50).w(context.screenWidth).pOnly(top: 20, right: 10, left: 10);
  }
}

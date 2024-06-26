import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomRegisterElevatedButton extends StatelessWidget {
  final Function() login;
  final String label;
  final Widget? child;
  final bool? isLoading;
  const CustomRegisterElevatedButton({
    super.key,
    required this.login,
    required this.label,
    this.child,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: login,
      child: isLoading != null
          ? LoadingAnimationWidget.inkDrop(
              color: Colors.white,
              size: 20,
            ).h(20).w(20)
          : child ?? label.text.bold.size(25).make(),
    ).h(60).w(context.screenWidth).pOnly(top: 20, right: 10, left: 10);
  }
}

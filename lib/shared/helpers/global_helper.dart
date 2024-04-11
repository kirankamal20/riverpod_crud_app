import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_crud_app/features/sign_out_btn/view/sign_out_btn_view.dart';
import 'package:velocity_x/velocity_x.dart';

mixin GlobalHelper<T extends StatefulWidget> on State<T> {
  void openDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(20),
        titlePadding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        title: const Center(child: Text('Logging out ?')),
        content: const Text('Are you sure about it?'),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('cancel'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('yes,logout'),
          ),
        ],
      ),
    );
  }

  void showCustomBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: context.screenHeight * 0.3,
        width: context.screenWidth,
        child: Column(
          children: [
            "Sign Out ?".text.size(32).bold.make().p(8),
            "Are you sure about it?'".text.size(20).make().p(8),
            const Gap(40),
            [
              const SignOutButtonView(),
              const Gap(10),
              OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: "Cancel".text.size(20).make())
                  .w(context.screenWidth * 0.8)
                  .h(55),
            ].vStack().objectBottomCenter()
          ],
        ).p(10),
      ),
    );
  }

  void showSnackBar(
      {required String errorMessage, required Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          errorMessage,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

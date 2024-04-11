import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_crud_app/features/data_sync/controller/data_sync_check_pod.dart';
import 'package:riverpod_crud_app/main.dart';
import 'package:riverpod_crud_app/shared/dio/dio_client_provider.dart';
import 'package:riverpod_crud_app/shared/helpers/global_helper.dart';
import 'package:riverpod_crud_app/shared/pod/internet_checker_pod.dart';
import 'package:riverpod_crud_app/shared/pod/offline_mode_pod.dart';

import 'package:velocity_x/velocity_x.dart';

class InternetCheckerWidget extends ConsumerStatefulWidget {
  const InternetCheckerWidget(
    Widget widget, {
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NoInternetWidgetState();
}

class _NoInternetWidgetState extends ConsumerState<InternetCheckerWidget>
    with GlobalHelper {
  InternetConnectionStatus? lastResult;

  void internetListener(
    InternetConnectionStatus status, {
    required void Function() onNoInternetOKPressed,
  }) {
    switch (status) {
      case InternetConnectionStatus.connected:
        talker.debug('Data Reconnected.');
        if (lastResult == InternetConnectionStatus.disconnected) {
          ref.invalidate(dioProvider);
          ref.invalidate(offlineGetallStudentPod);
          ScaffoldMessenger.of(context)
            ..clearMaterialBanners()
            ..showMaterialBanner(
              MaterialBanner(
                content: const Text(
                  'Got Internet ...... Refreshed',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          Future.delayed(
            const Duration(seconds: 2),
            () {
              ScaffoldMessenger.of(context).clearMaterialBanners();
            },
          );
        } else {
          talker.debug('First time');
        }

        break;
      case InternetConnectionStatus.disconnected:
        talker.debug('You are disconnected from the internet.');
        ScaffoldMessenger.of(context)
          ..clearMaterialBanners()
          ..showMaterialBanner(
            MaterialBanner(
              content: const Text(
                'No Internet Available',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    onNoInternetOKPressed();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        break;
    }
    lastResult = status;
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(internetCheckerPod);
    final continueWithOffline = ref.watch(offlineModePod);
    ref.listen(
      internetCheckerPod,
      (previous, next) {
        final status = next.value;
        if (status != null) {
          internetListener(
            status,
            onNoInternetOKPressed: () {
              ref.invalidate(internetCheckerPod);
              statusAsync.whenData((status) {
                if (status == InternetConnectionStatus.connected) {
                  ref.read(offlineModePod.notifier).update((state) => false);
                  ScaffoldMessenger.of(context).clearMaterialBanners();
                }
              });
            },
          );
        }
      },
    );
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: !kIsWeb
          ? statusAsync.when(
              data: (status) {
                switch (status) {
                  case InternetConnectionStatus.connected:
                    return widget.child;
                  case InternetConnectionStatus.disconnected:
                    return continueWithOffline
                        ? widget.child
                        : Scaffold(
                            body: <Widget>[
                              // RiveAnimation.asset(
                              //   "assets/anim/nointernet.riv",
                              //   fit: BoxFit.cover,
                              // ).box.height(context.screenHeight).make(),

                              // const Text(
                              //   'No Internet Connection',
                              //   style: TextStyle(fontSize: 24),
                              // ),
                              // const SizedBox(height: 20),
                              // ElevatedButton(
                              //   onPressed: () {},
                              //   child: const Text('Retry'),
                              // ),
                              Center(
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(offlineModePod.notifier)
                                            .update((state) => true);
                                        ScaffoldMessenger.of(context)
                                            .clearMaterialBanners();
                                      },
                                      child: const Text(
                                          'Continue with offline mode'),
                                    );
                                  },
                                ),
                              ),
                            ].stack(clip: Clip.none),
                          );
                }
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => const Column(
                children: [
                  // Center(
                  //   key: const Key('centerKey'),
                  //   child: Image.asset(R.ASSETS_IMAGES_LOGO_PNG),
                  // ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            )
          : widget.child,
    );
  }
}

















// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:riverpod_crud_app/shared/pod/internet_checker_pod.dart';
// import 'package:riverpod_crud_app/shared/pod/offline_mode_pod.dart';

// class NoInternetWidget extends ConsumerWidget {
//   final Widget child;
//   const NoInternetWidget(this.child, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final internetChecker = ref.watch(internetCheckerPod);
//     final continueWithOffline = ref.watch(offlineModePod);
//     return internetChecker.when(
//       data: (data) {
//         switch (data) {
//           case InternetConnectionStatus.connected:
//             ref.invalidate(offlineModePod);
//             return child;
//           case InternetConnectionStatus.disconnected:
//             return continueWithOffline ? child : const NoInternetScreen();
//         }
//       },
//       error: (error, stackTrace) => Text(error.toString()),
//       loading: () => const CircularProgressIndicator(),
//     );
//   }
// }

// class NoInternetScreen extends StatelessWidget {
//   const NoInternetScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'No Internet Connection',
//               style: TextStyle(fontSize: 24),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {},
//               child: const Text('Retry'),
//             ),
//             Consumer(
//               builder: (context, ref, child) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     ref.read(offlineModePod.notifier).update((state) => true);
//                   },
//                   child: const Text('Continue with offline mode'),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

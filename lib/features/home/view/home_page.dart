import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_crud_app/core/const/colors.dart';
import 'package:riverpod_crud_app/core/theme/theme_controller.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/model/update_student_details_arg.dart';
import 'package:riverpod_crud_app/features/home/controller/get_all_students_pod.dart';
import 'package:riverpod_crud_app/features/home/view/widgets/custom_card.dart';
import 'package:riverpod_crud_app/features/home/view/widgets/dark_transition.dart';
import 'package:riverpod_crud_app/features/home/view/widgets/theme_mode_button.dart';
import 'package:riverpod_crud_app/l10n/l10n.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';
import 'package:riverpod_crud_app/shared/pod/locale_pod.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isDark = false;
  Random random = Random();
  GlobalKey key = GlobalKey();
  Offset position = Offset.zero;
  bool isEnable = false;
  bool accepted2 = false;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DarkTransition(
      isDark:
          ref.watch(themecontrollerProvider) == ThemeMode.dark ? true : false,
      offset: const Offset(700, 0),
      duration: const Duration(milliseconds: 800),
      childBuilder: (context, int index) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.logout)),
              IconButton(
                  onPressed: () {
                    ref.read(autorouterprovider).navigate(const SearchRoute());
                  },
                  icon: const Icon(Icons.search)),
              Consumer(
                builder: (context, ref, child) {
                  return PopupMenuButton<int>(
                    icon: const Icon(Icons.language),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        onTap: () {
                          ref.read(localePod.notifier).changeLocale(
                              context: context, locale: const Locale('en'));
                        },
                        child: const Text("English"),
                      ),
                      PopupMenuItem(
                        value: 2,
                        onTap: () {
                          ref.read(localePod.notifier).changeLocale(
                              context: context, locale: const Locale('ml'));
                        },
                        child: const Text("മലയാളം"),
                      ),
                    ],
                    offset: const Offset(0, 100),
                    color: Colors.white,
                    elevation: 2,
                  );
                },
              ),
              GestureDetector(
                child: const ThemeModeButton(),
                onTap: () => print('tapped!'),
                onTapDown: (TapDownDetails details) => print(details),
                onTapUp: (TapUpDetails details) => print(details),
              )
            ],
          ),
          body: Consumer(
            builder: (BuildContext context, WidgetRef ref, __) {
              final getAllStudents = ref.watch(getllStudentsPod);
              return getAllStudents.when(
                  data: (data) => data.isNotEmpty
                      ? Stack(
                          children: [
                            RefreshIndicator(
                              onRefresh: () async {
                                ref.invalidate(getllStudentsPod);
                              },
                              child: GridView.builder(
                                itemCount: data.length,
                                padding: const EdgeInsets.all(10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.72),
                                itemBuilder: (context, index) {
                                  final student = data[index];
                                  int randomIndex =
                                      random.nextInt(colorsList.length);

                                  final colorList = colorsList[0];
                                  return LongPressDraggable(
                                    data: student.id,
                                    dragAnchorStrategy: (Draggable<Object> _,
                                        BuildContext context, Offset ___) {
                                      return const Offset(-100, -100);
                                    },
                                    feedback: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: const Icon(Icons.delete)
                                          .box
                                          .color(Colors.yellow)
                                          .height(100)
                                          .width(100)
                                          .make(),
                                    ),
                                    childWhenDragging: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: const Icon(Icons.delete)
                                          .box
                                          .color(Colors.blue)
                                          .height(100)
                                          .width(100)
                                          .make(),
                                    ),
                                    onDragStarted: () {
                                      setState(() {
                                        isEnable = true;
                                      });
                                    },
                                    onDraggableCanceled: (velocity, offset) {
                                      setState(() {
                                        isEnable = false;
                                      });
                                    },
                                    onDragCompleted: () {
                                      print("drag completed  ");
                                      setState(() {
                                        isEnable = false;
                                      });
                                    },
                                    child: CustomCard(student: student),
                                  );
                                },
                              ),
                            ),
                            // isEnable
                            //     ?
                            // DragTarget<int>(
                            //   builder: (
                            //     BuildContext context,
                            //     List<int?> accepted,
                            //     List<dynamic> rejected,
                            //   ) {
                            //     var color =
                            //         accepted2 ? Colors.yellow : Colors.red;
                            //     return const Icon(Icons.delete)
                            //         .box
                            //         .color(color)
                            //         .height(100)
                            //         .width(100)
                            //         .make();
                            //   },
                            //   // onAcceptWithDetails: (data) {
                            //   //   setState(() {
                            //   //     accepted2 = true;
                            //   //   });
                            //   //   print("accepted2");
                            //   // },
                            //   onWillAccept: (data) {
                            //     return true;
                            //   },
                            //   onAccept: (data) {
                            //     print("accepted2");
                            //   },
                            //   // onWillAcceptWithDetails: (data) {
                            //   //   setState(() {
                            //   //     accepted2 = true;
                            //   //   });
                            //   //   // setState(() {
                            //   //   //   isEnable = false;
                            //   //   // });
                            //   //   return true;
                            //   // },
                            // ).p(20).objectBottomCenter()
                            // : const SizedBox.shrink(),
                          ],
                        )
                      : "Student Not found".text.make().objectCenter(),
                  error: (error, stackTrace) => [
                        error.toString().text.make(),
                        IconButton(
                            onPressed: () {
                              ref.invalidate(getllStudentsPod);
                            },
                            icon: const Icon(Icons.replay_outlined))
                      ].vStack(alignment: MainAxisAlignment.center),
                  loading: () =>
                      const CircularProgressIndicator().objectCenter(),
                  skipLoadingOnReload: false,
                  skipLoadingOnRefresh: false);
            },
          ).objectCenter(),
          floatingActionButton: Consumer(
            builder: (context, ref, child) {
              return FloatingActionButton(
                heroTag: null,
                child: const Icon(Icons.add),
                onPressed: () {
                  ref.read(autorouterprovider).navigate(
                        AddStudentRoute(
                          updateStudent: UpdateStudent(
                              screenName: "Add Student",
                              studentId: 0,
                              name: '',
                              age: '',
                              dob: '',
                              gender: '',
                              country: ''),
                        ),
                      );
                },
              );
            },
          ),
        );
      },
    );
  }
}

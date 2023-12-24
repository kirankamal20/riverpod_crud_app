import 'dart:math';

import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_crud_app/core/theme/theme_controller.dart';
import 'package:riverpod_crud_app/features/home/controller/get_all_students_pod.dart';
import 'package:riverpod_crud_app/features/home/view/widgets/dark_transition.dart';
import 'package:riverpod_crud_app/features/home/view/widgets/theme_mode_button.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isDark = false;

  GlobalKey key = GlobalKey();
  Offset position = Offset.zero;
  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
                child: const ThemeModeButton(),
                onTap: () => print('tapped!'),
                onTapDown: (TapDownDetails details) => print(details),
                onTapUp: (TapUpDetails details) => print(details),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Consumer(
              builder: (_, WidgetRef ref, __) {
                final getAllStudents = ref.watch(getllStudentsPod);
                return getAllStudents.when(
                    data: (data) => data.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () async {
                              // await fetchstudents();
                            },
                            child: [
                              GridView.builder(
                                itemCount: data.length,
                                padding: const EdgeInsets.all(10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.62),
                                itemBuilder: (context, index) {
                                  final student = data[index];
                                  return Stack(
                                    children: [
                                      CachedNetworkImage(
                                        height: context.screenHeight * 0.17,
                                        width: double.infinity,
                                        imageUrl:
                                            "https://studentcrudfastapi-production.up.railway.app/download-image/${student.image}",
                                        imageBuilder:
                                            (context, imageProvider) => VxBox()
                                                .bgImage(DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ))
                                                .withRounded(value: 20)
                                                .make(),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fadeInDuration:
                                            const Duration(milliseconds: 300),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 230,
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () async {},
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      VStack(
                                        [
                                          Text(
                                            student.student_name,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ).w(100),
                                          const SizedBox(height: 4),
                                          'Age: ${student.student_age}'
                                              .text
                                              .size(14)
                                              .make(),
                                          const SizedBox(height: 4),
                                          'DOB: ${student.date_of_birth}'
                                              .text
                                              .size(14)
                                              .make(),
                                          const SizedBox(height: 4),
                                          'Gender: ${student.gender}'
                                              .text
                                              .size(14)
                                              .make(),
                                          const SizedBox(height: 4),
                                          'Country: ${student.country}'
                                              .text
                                              .size(14)
                                              .make(),
                                        ],
                                        alignment: MainAxisAlignment.start,
                                      ).p(20).positioned(bottom: 3),
                                    ],
                                  )
                                      .box
                                      .red100
                                      .withRounded(value: 20)
                                      .make()
                                      .pSymmetric(v: 8, h: 10);
                                },
                              ).h(context.screenHeight * 0.79),

                              const Gap(
                                10,
                              ),
                              // buildPagination(),
                              const Gap(
                                15,
                              )
                            ].vStack(),
                          )
                        : "Student Not found"
                            .text
                            .make()
                            .pSymmetric(v: context.screenHeight * 0.2)
                            .centered(),
                    error: (error, stackTrace) => error.toString().text.make(),
                    loading: () => const CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    );
  }
}

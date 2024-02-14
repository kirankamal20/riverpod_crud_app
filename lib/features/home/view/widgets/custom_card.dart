import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/model/update_student_details_arg.dart';
import 'package:riverpod_crud_app/l10n/l10n.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.student,
  });

  final Getallstudents student;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CachedNetworkImage(
            height: context.screenHeight * 0.14,
            width: double.infinity,
            imageUrl:
                "https://fastapi-student-crud.onrender.com/download-image/${student.image}",
            imageBuilder: (context, imageProvider) => VxBox()
                .bgImage(DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ))
                .withRounded(value: 20)
                .make(),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error), // Handle error here
            fadeInDuration: const Duration(milliseconds: 300),
          ),
        ),
        // Positioned(
        //   top: 5,
        //   right: 5,
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.delete,
        //       color: Colors.red,
        //     ),
        //   ),
        // ),
        Positioned(
          top: 230,
          right: 0,
          child: Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.read(autorouterprovider).navigate(AddStudentRoute(
                        updateStudent: UpdateStudent(
                          screenName: "Update Student",
                          name: student.student_name,
                          age: student.student_age,
                          dob: student.date_of_birth,
                          gender: student.gender,
                          country: student.country,
                          studentId: student.id,
                        ),
                      ));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              );
            },
          ),
        ),
        VStack(
          [
            student.student_name.text.bold.xl
                .overflow(TextOverflow.ellipsis)
                .make()
                .w(100),
            const Gap(4),
            '${l10n.age} : ${student.student_age}'.text.make(),
            const SizedBox(height: 4),
            '${l10n.dob}: ${student.date_of_birth}'.text.make(),
            const SizedBox(height: 4),
            '${l10n.gender}: ${student.gender}'.text.make(),
            const SizedBox(height: 4),
            '${l10n.country}: ${student.country}'.text.make(),
          ],
          alignment: MainAxisAlignment.start,
        ).p(10).positioned(bottom: 3),
      ],
    )
        .box
        .color(context.isDarkMode ? Colors.black : Colors.white)
        .withShadow([
          BoxShadow(
            color:
                context.isDarkMode ? Colors.black : Colors.grey.withOpacity(.6),
            blurRadius: 0.5,
          ),
        ])
        .withRounded(value: 20)
        .make()
        .pSymmetric(v: 8, h: 10);
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/l10n/l10n.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.student,
  });

  final Getallstudents student;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: CachedNetworkImage(
            height: 100,
            width: 100,
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
        ).p(10),
        // Consumer(
        //   builder: (context, ref, child) {
        //     return IconButton(
        //       onPressed: () {
        //         ref.read(autorouterprovider).navigate(AddStudentRoute(
        //               updateStudent: UpdateStudent(
        //                 screenName: "Update Student",
        //                 name: student.student_name,
        //                 age: student.student_age,
        //                 dob: student.date_of_birth,
        //                 gender: student.gender,
        //                 country: student.country,
        //                 studentId: student.id,
        //               ),
        //             ));
        //       },
        //       icon: const Icon(
        //         Icons.edit,
        //         color: Colors.blue,
        //       ),
        //     );
        //   },
        // ),
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
        .pSymmetric(v: 8, h: 17);
  }
}

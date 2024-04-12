import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:riverpod_crud_app/data/model/get_all_students_model.dart';
import 'package:riverpod_crud_app/data/model/update_student_details_arg.dart';
import 'package:riverpod_crud_app/features/delete_btn/view/delete_btn_view.dart';
import 'package:riverpod_crud_app/l10n/l10n.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:riverpod_crud_app/router/router.gr.dart';
import 'package:riverpod_crud_app/shared/helpers/global_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomCard extends ConsumerStatefulWidget {
  const CustomCard({
    super.key,
    required this.student,
  });

  final Getallstudents student;

  @override
  ConsumerState<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends ConsumerState<CustomCard> with GlobalHelper {
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
                "https://fastapi-student-crud.onrender.com/download-image/${widget.student.image}",
            imageBuilder: (context, imageProvider) => VxBox()
                .bgImage(DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ))
                .withRounded(value: 20)
                .make(),
            placeholder: (context, url) => Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF1A1A3F),
                rightDotColor: const Color(0xFFEA3799),
                size: 30,
              ),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error), // Handle error here
            fadeInDuration: const Duration(milliseconds: 300),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: DeleteBtnView(
            getallstudents:widget. student,
            onError: (errorMessage) {
              showSnackBar(
                  errorMessage: errorMessage, backgroundColor: Colors.red);
            },
            onSuccess: (successMessage) {
              showSnackBar(
                  errorMessage: "Successfully Deleted",
                  backgroundColor: Colors.blue);
            },
          ),
        ),
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
                          name: widget.student.student_name,
                          age: widget.student.student_age,
                          dob: widget.student.date_of_birth,
                          gender: widget.student.gender,
                          country: widget.student.country,
                          studentId: widget.student.id,
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
            widget.student.student_name.text.bold.xl
                .overflow(TextOverflow.ellipsis)
                .make()
                .w(100),
            const Gap(4),
            '${l10n.age} : ${widget.student.student_age}'.text.make(),
            const SizedBox(height: 4),
            '${l10n.dob}: ${widget.student.date_of_birth}'.text.make(),
            const SizedBox(height: 4),
            '${l10n.gender}: ${widget.student.gender}'.text.make(),
            const SizedBox(height: 4),
            '${l10n.country}: ${widget.student.country}'.text.make(),
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

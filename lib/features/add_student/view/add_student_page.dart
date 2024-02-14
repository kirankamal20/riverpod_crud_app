import 'package:auto_route/auto_route.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_crud_app/data/model/update_student_details_arg.dart';
import 'package:riverpod_crud_app/features/add_student/controller/notifier/add_student_notifier.dart';
import 'package:riverpod_crud_app/features/add_student/view/ui_state/add_student_notifier_sate.dart';
import 'package:riverpod_crud_app/features/home/controller/get_all_students_pod.dart';
import 'package:riverpod_crud_app/l10n/l10n.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AddStudentPage extends ConsumerStatefulWidget {
  final UpdateStudent updateStudent;
  const AddStudentPage({required this.updateStudent, super.key});

  @override
  ConsumerState<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends ConsumerState<AddStudentPage> {
  final formkey = GlobalKey<FormBuilderState>();
  void onSubmit() {
    List<XFile> images = [];
    print("Executed");
    if (formkey.currentState!.validate()) {
      print("Executed2");
      final studentName = formkey.currentState!.fields['NameField']!.value;
      final studentAge = formkey.currentState!.fields['AgeField']!.value;
      final dateOfBirth =
          formkey.currentState!.fields['dob']!.value as DateTime;
      final gender = formkey.currentState!.fields['gender']!.value;
      final country = formkey.currentState!.fields['countryField']?.value ?? "";
      List<dynamic> fields = formkey.currentState!.fields['photo']!.value;
      XFile imageXfile = fields.first as XFile;
      images.add(imageXfile);
      String formattedDate = DateFormat('dd/MM/yyyy').format(dateOfBirth);
      if (widget.updateStudent.screenName == "Add Student") {
        ref.read(addStudentNotifierPod.notifier).addStudent(
            filePath: images.first.path,
            studentName: studentName,
            studentAge: studentAge,
            dateOfBirth: formattedDate,
            gender: gender,
            country: country,
            onSuccess: () {
              ref.invalidate(getllStudentsPod);
              ref.read(autorouterprovider).pop();
            },
            onError: (String errorMessage) {});
      } else {
        ref.read(addStudentNotifierPod.notifier).updateStudent(
            filePath: images.first.path,
            studentName: studentName,
            studentAge: studentAge,
            dateOfBirth: formattedDate,
            gender: gender,
            country: country,
            onSuccess: () {
              ref.invalidate(getllStudentsPod);
              ref.read(autorouterprovider).pop();
            },
            onError: (String errorMessage) {},
            studentId: widget.updateStudent.studentId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: widget.updateStudent.screenName == "Add Student"
            ? l10n.add_student.text.make()
            : l10n.update_student.text.make(),
      ),
      body: FormBuilder(
        key: formkey,
        initialValue: {
          'NameField': widget.updateStudent.name,
          'AgeField': widget.updateStudent.age,
          'dob': widget.updateStudent.dob.isNotEmpty
              ? DateFormat('dd/MM/yyyy').parse(widget.updateStudent.dob)
              : null,
          'gender': widget.updateStudent.gender,
          'countryField': widget.updateStudent.country,
        },
        child: [
          FormBuilderTextField(
            name: "NameField",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              label: l10n.name.text.make(),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
            ),
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(
                    errorText: l10n.name_validation_errormessage)
              ],
            ),
          ).pOnly(bottom: 15),
          FormBuilderTextField(
            name: "AgeField",
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: l10n.age.text.make(),
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
            ),
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(
                    errorText: l10n.age_validation_errormessage)
              ],
            ),
          ).pOnly(bottom: 15),
          FormBuilderField<DateTime>(
            name: 'dob',
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(
                    errorText: l10n.dob_validation_errormessage)
              ],
            ),
            onChanged: (val) => debugPrint(val.toString()),
            builder: (FormFieldState<DateTime> field) {
              return TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: TextEditingController(
                    text: field.value != null
                        ? DateFormat('dd/MM/yyyy').format(field.value!)
                        : null),
                decoration: InputDecoration(
                    label: l10n.dob.text.make(),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.all(18),
                    error: field.errorText?.toString().text.make()),
                onTap: () => BottomPicker.date(
                  title: 'Set your Birthday',
                  dateOrder: DatePickerDateOrder.dmy,
                  initialDateTime: widget.updateStudent.dob.isEmpty
                      ? DateTime(1996, 10, 22)
                      : DateFormat('dd/MM/yyyy')
                          .parse(widget.updateStudent.dob),
                  maxDateTime: DateTime(1998),
                  minDateTime: DateTime(1980),
                  pickerTextStyle: const TextStyle(
                    // color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  titleStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.blue,
                  ),
                  // onChange: (index) {
                  //   field.didChange(index as DateTime);
                  // },
                  onSubmit: (index) {
                    field.didChange(index as DateTime);
                  },
                  bottomPickerTheme: BottomPickerTheme.morningSalad,
                ).show(context),
                showCursor: false,
                readOnly: true,
              );
            },
          ).pOnly(bottom: 15),
          FormBuilderDropdown(
            name: 'gender',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: l10n.gender,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(18),
            ),
            items: ['Male', 'Female', 'Other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(
                    errorText: l10n.gender_validation_errormessage)
              ],
            ),
          ).pOnly(bottom: 15),
          [
            const Gap(10),
            l10n.select_country.text.make(),
            const Gap(10),
            FormBuilderField<String?>(
              name: 'countryField',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()],
              ),
              onChanged: (val) => debugPrint(val.toString()),
              builder: (FormFieldState<String?> field) {
                return InputDecorator(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8)),
                  child: CountryCodePicker(
                    onChanged: (value) {
                      field.didChange(value.name);
                    },
                    initialSelection: 'IN',
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: false,
                  ),
                );
              },
            ),
          ].vStack(crossAlignment: CrossAxisAlignment.start).pOnly(bottom: 15),
          FormBuilderImagePicker(
            name: 'photo',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                labelText: l10n.pick_photo, border: const OutlineInputBorder()),
            maxImages: 1,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(
                    errorText: l10n.picture_validation_errormessage)
              ],
            ),
          ),
        ].vStack(crossAlignment: CrossAxisAlignment.start).p(20),
      ).scrollVertical(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: Consumer(
        builder: (context, ref, child) {
          final addStudentAsync = ref.watch(addStudentNotifierPod);
          return addStudentAsync.when(
              data: (data) => switch (data) {
                    InitialAddStudentState() => ElevatedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: widget.updateStudent.screenName == "Add Student"
                            ? l10n.add_student.text.white.make()
                            : l10n.update_student.text.white.make()),
                    LoadingAddStudentState() => ElevatedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: "${l10n.uploading} ${data.percentage} %"
                            .text
                            .white
                            .make()),
                    AddStudentStateSuccessState() => ElevatedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: l10n.success.text.white.make()),
                    AddStudentStateErrorState() => ElevatedButton(
                        onPressed: () {
                          onSubmit();
                        },
                        child: l10n.error.text.white.make()),
                  },
              error: (Object error, StackTrace stackTrace) =>
                  error.toString().text.make(),
              loading: () => const CircularProgressIndicator());
        },
      ).w(350).h(60),
    );
  }
}

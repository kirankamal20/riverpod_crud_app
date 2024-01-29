// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateStudent {
  final int studentId;
  final String name;
  final String age;
  final String dob;
  final String gender;
  final String country;
  final String screenName;

  UpdateStudent({
    required this.studentId,
    required this.screenName,
    required this.name,
    required this.age,
    required this.dob,
    required this.gender,
    required this.country,
  });
}

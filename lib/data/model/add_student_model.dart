// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddStudentModel {
  final String studentId;
  final String studentCreationDateTime;
  final String imageFilePath;
  final String studentName;
  final String studentAge;
  final String dateOfBirth;
  final String gender;
  final String country;
  final bool isSync;
  AddStudentModel({
    required this.studentId,
    required this.studentCreationDateTime,
    required this.imageFilePath,
    required this.studentName,
    required this.studentAge,
    required this.dateOfBirth,
    required this.gender,
    required this.country,
    required this.isSync,
  });

  AddStudentModel copyWith({
    String? studentId,
    String? studentCreationDateTime,
    String? imageFilePath,
    String? studentName,
    String? studentAge,
    String? dateOfBirth,
    String? gender,
    String? country,
    bool? isSync,
  }) {
    return AddStudentModel(
      studentId: studentId ?? this.studentId,
      studentCreationDateTime:
          studentCreationDateTime ?? this.studentCreationDateTime,
      imageFilePath: imageFilePath ?? this.imageFilePath,
      studentName: studentName ?? this.studentName,
      studentAge: studentAge ?? this.studentAge,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      isSync: isSync ?? this.isSync,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'studentCreationDateTime': studentCreationDateTime,
      'imageFilePath': imageFilePath,
      'studentName': studentName,
      'studentAge': studentAge,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'country': country,
      'isSync': isSync,
    };
  }

  factory AddStudentModel.fromMap(Map<String, dynamic> map) {
    return AddStudentModel(
      studentId: map['studentId'] as String,
      studentCreationDateTime: map['studentCreationDateTime'] as String,
      imageFilePath: map['imageFilePath'] as String,
      studentName: map['studentName'] as String,
      studentAge: map['studentAge'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      country: map['country'] as String,
      isSync: map['isSync'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddStudentModel.fromJson(String source) =>
      AddStudentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddStudentModel(studentId: $studentId, studentCreationDateTime: $studentCreationDateTime, imageFilePath: $imageFilePath, studentName: $studentName, studentAge: $studentAge, dateOfBirth: $dateOfBirth, gender: $gender, country: $country, isSync: $isSync)';
  }

  @override
  bool operator ==(covariant AddStudentModel other) {
    if (identical(this, other)) return true;

    return other.studentId == studentId &&
        other.studentCreationDateTime == studentCreationDateTime &&
        other.imageFilePath == imageFilePath &&
        other.studentName == studentName &&
        other.studentAge == studentAge &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.country == country &&
        other.isSync == isSync;
  }

  @override
  int get hashCode {
    return studentId.hashCode ^
        studentCreationDateTime.hashCode ^
        imageFilePath.hashCode ^
        studentName.hashCode ^
        studentAge.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        country.hashCode ^
        isSync.hashCode;
  }
}

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Getallstudents {
  final String student_age;
  final int id;
  final String country;
  final String image;
  final String date_of_birth;
  final String student_name;
  final String gender;
  final int owner_id;
  Getallstudents({
    required this.student_age,
    required this.id,
    required this.country,
    required this.image,
    required this.date_of_birth,
    required this.student_name,
    required this.gender,
    required this.owner_id,
  });

  Getallstudents copyWith({
    String? student_age,
    int? id,
    String? country,
    String? image,
    String? date_of_birth,
    String? student_name,
    String? gender,
    int? owner_id,
  }) {
    return Getallstudents(
      student_age: student_age ?? this.student_age,
      id: id ?? this.id,
      country: country ?? this.country,
      image: image ?? this.image,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      student_name: student_name ?? this.student_name,
      gender: gender ?? this.gender,
      owner_id: owner_id ?? this.owner_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'student_age': student_age,
      'id': id,
      'country': country,
      'image': image,
      'date_of_birth': date_of_birth,
      'student_name': student_name,
      'gender': gender,
      'owner_id': owner_id,
    };
  }

  factory Getallstudents.fromMap(Map<String, dynamic> map) {
    return Getallstudents(
      student_age: map['student_age'] as String,
      id: map['id'].toInt() as int,
      country: map['country'] as String,
      image: map['image'] as String,
      date_of_birth: map['date_of_birth'] as String,
      student_name: map['student_name'] as String,
      gender: map['gender'] as String,
      owner_id: map['owner_id'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Getallstudents.fromJson(String source) =>
      Getallstudents.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Getallstudents(student_age: $student_age, id: $id, country: $country, image: $image, date_of_birth: $date_of_birth, student_name: $student_name, gender: $gender, owner_id: $owner_id)';
  }

  @override
  bool operator ==(covariant Getallstudents other) {
    if (identical(this, other)) return true;

    return other.student_age == student_age &&
        other.id == id &&
        other.country == country &&
        other.image == image &&
        other.date_of_birth == date_of_birth &&
        other.student_name == student_name &&
        other.gender == gender &&
        other.owner_id == owner_id;
  }

  @override
  int get hashCode {
    return student_age.hashCode ^
        id.hashCode ^
        country.hashCode ^
        image.hashCode ^
        date_of_birth.hashCode ^
        student_name.hashCode ^
        gender.hashCode ^
        owner_id.hashCode;
  }
}

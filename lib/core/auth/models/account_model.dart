import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unikomb/utils/enums.dart';

class AccountModel {
  AccountModel({
    required this.name,
    required this.dob,
    required this.uid,
    required this.course,
    required this.joiningYear,
    required this.picUrl,
    required this.email,
    this.skills = const [],
    this.projects = const [],
    this.id = "",
    this.bio,
    this.linkedinUrl,
    this.joiningDate,
  });
  String id = "";
  String name = "";
  String email = "";
  String picUrl = '';
  int dob = 0;
  String uid = "";
  String course = "";
  int joiningYear = 0;

  List<dynamic> skills = [];
  List<dynamic> projects = [];
  String? bio;
  String? linkedinUrl;
  Timestamp? joiningDate;

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    joiningDate = json['joiningDate'];
    name = json['name'];
    picUrl = json['picUrl'];
    email = json['email'];
    dob = json['dob'];
    uid = json['uid'];
    course = json['course'];
    joiningYear = json['joiningYear'];
    skills = List.castFrom<dynamic, dynamic>(json['skills']);
    projects = List.castFrom<dynamic, dynamic>(json['projects']);
    bio = json['bio'];
    linkedinUrl = json['linkedinUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['picUrl'] = picUrl;
    data['email'] = email;
    data['dob'] = dob;
    data['uid'] = uid;
    data['course'] = course;
    data['joiningYear'] = joiningYear;
    data['skills'] = skills;
    data['projects'] = projects;
    data['bio'] = bio;
    data['linkedinUrl'] = linkedinUrl;
    data['joiningDate'] = joiningDate;
    return data;
  }
}

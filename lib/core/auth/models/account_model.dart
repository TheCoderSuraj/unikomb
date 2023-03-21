import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unikomb/core/auth/models/project_model.dart';
import 'package:unikomb/core/auth/models/skill_model.dart';
import 'package:unikomb/utils/constants.dart';
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
    this.leetUsername,
  });
  String id = "";
  String name = "";
  String email = "";
  String picUrl = '';
  int dob = 0;
  String uid = "";
  String course = "";
  String? leetUsername;
  int joiningYear = 0;

  List<SkillModel> skills = [];
  List<ProjectModel> projects = [];
  String? bio;
  String? linkedinUrl;
  Timestamp? joiningDate;

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leetUsername = json['leetUsername'];
    joiningDate = json['joiningDate'];
    name = json['name'];
    picUrl = json['picUrl'];
    email = json['email'];
    dob = json['dob'];
    uid = json['uid'];
    course = json['course'];
    joiningYear = json['joiningYear'];
    skills = List.castFrom<dynamic, SkillModel>(json['skills']);
    projects = List.castFrom<dynamic, ProjectModel>(json['projects']);
    bio = json['bio'];
    linkedinUrl = json['linkedinUrl'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['leetUsername'] = leetUsername;
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

  AccountModel.demo() {
    id = "1234";
    name = "Suraj Kiran";
    picUrl = kTestImgUrl;
    email = "test@gmail.com";
    dob = DateTime.now().millisecondsSinceEpoch;
    uid = "22bae343541";
    course = "cse";
    joiningYear = 2022;
    skills = [
      SkillModel(title: 'c'),
      SkillModel(title: 'c++'),
      SkillModel(title: 'python'),
      SkillModel(title: 'flutter'),
    ];
    projects = [
      ProjectModel(
          title: "title thie;aie ioeuiheaslui easuieuldu e",
          desc: "desc",
          skill: [SkillModel(title: "c")],
          url: "url"),
      ProjectModel(
          title: "title dlfa oeauhei 23873beq87 873q",
          desc: "desc",
          skill: [SkillModel(title: "c")],
          url: "url"),
    ];
    bio = "this is a test account";
    linkedinUrl = "https://www.google.com";
    joiningDate = Timestamp.now();
  }
}

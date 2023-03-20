import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';
import 'package:unikomb/core/auth/models/skill_model.dart';
import 'package:unikomb/core/auth/models/account_model.dart';

import '../models/project_model.dart';

class RegistrationProvider extends ChangeNotifier {
  String _name = "";
  String get name => _name;

  String _uid = "";
  String get uid => _uid;

  String _course = "";
  String get course => _course;

  String _profileUrl = "";
  String get profileUrl => _profileUrl;

  int _joinYr = 0;
  int get joinYr => _joinYr;

  int _dob = 0;
  int get dob => _dob;

  String? _bio;
  String? get bio => _bio;

  String? _linkedin;
  String? get linkedin => _linkedin;

  List<ProjectModel> _projects = [];
  List<ProjectModel> get projects => _projects;

  List<SkillModel> _skills = [];
  List<SkillModel> get skills => _skills;

  void setCompulsoryParam(
    String nam,
    String universityId,
    String profile,
    String cou,
    int joiningYr,
    int dob,
  ) {
    _name = nam;
    _profileUrl = profile;
    _joinYr = joiningYr;
    _dob = dob;
    _uid = universityId;
    _course = cou;
    // notifyListeners();
  }

  void setBio(String value) {
    _bio = value;
    // notifyListeners();
  }

  void setUrl(String value) {
    _profileUrl = value;
    // notifyListeners();
  }

  void setCourse(String value) {
    _course = value;
    // notifyListeners();
  }

  void setLinkedin(String value) {
    _linkedin = value;
    // notifyListeners();
  }

  void setProjects(List<ProjectModel> values) {
    _projects = values;
  }

  void setSkills(List<SkillModel> values) {
    _skills = values;
  }

  AccountModel getModel() {
    return AccountModel(
      name: name,
      dob: dob,
      uid: uid,
      course: course,
      joiningYear: joinYr,
      picUrl: profileUrl,
      linkedinUrl: linkedin,
      bio: bio,
      skills: skills,
      projects: projects,
      email: Auth.getUserEmailAddress(),
      joiningDate: Timestamp.now(),
    );
  }
}

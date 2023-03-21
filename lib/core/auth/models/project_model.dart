import 'package:unikomb/core/auth/models/skill_model.dart';

class ProjectModel {
  ProjectModel({
    required this.title,
    required this.desc,
    required this.skill,
    required this.url,
  });
  late String title;
  late String desc;
  late String url;
  List<SkillModel> skill = [];

  ProjectModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    skill = json['skill'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['skill'] = skill;
    data['url'] = url;
    return data;
  }
}

// {
//   "title":"",
//   "desc":"",
//   "skill":"",
//   "url":""
// }
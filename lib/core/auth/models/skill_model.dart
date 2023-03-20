class SkillModel {
  SkillModel({
    required this.title,
    this.level = 1,
  });
  String title = "";

  /// rate out of 10
  int level = 1;

  SkillModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['level'] = level;
    return data;
  }
}
// {
//   "title":"",
//   "level":2
// }
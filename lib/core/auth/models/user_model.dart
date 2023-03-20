class UserModel {
  UserModel({
    required this.name,
    required this.dob,
    required this.uid,
    required this.course,
    required this.joiningYear,
    required this.picUrl,
    this.skills = const [],
    this.projects = const [],
    this.id = "",
    this.bio,
    this.linkedinUrl,
  });
  String id = "";
  String name = "";
  String picUrl = '';
  int dob = 0;
  String uid = "";
  String course = "";
  int joiningYear = 0;
  List<dynamic> skills = [];
  List<dynamic> projects = [];
  String? bio;
  String? linkedinUrl;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
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
    data['dob'] = dob;
    data['uid'] = uid;
    data['course'] = course;
    data['joiningYear'] = joiningYear;
    data['skills'] = skills;
    data['projects'] = projects;
    data['bio'] = bio;
    data['linkedinUrl'] = linkedinUrl;
    return data;
  }
}

// {
//   "id":"",
//   "name":"",
//   "dob":123,
//   "uid":"",
//   "course":"cse",
//   "joiningYear":2020,
//   "skills":[],
//   "projects":[],
//   "bio":"",
//   "linkedinUrl":""
// }
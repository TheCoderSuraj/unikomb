import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommunityModel {
  CommunityModel({
    required this.name,
    required this.picUrl,
    required this.createdBy,
    required this.creationDate,
    required this.skill,
    // required this.categorys,
    this.members = const [],
    this.joiningDate,
    this.id = "",
  });
  late String id;
  late String name;
  late String picUrl;
  late String createdBy;
  late int creationDate;
  late String skill;
  // list of memberId
  late List<String> members;
  // late String categorys;
  late Timestamp? joiningDate;

  CommunityModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    picUrl = json['picUrl'];
    createdBy = json['createdBy'];
    creationDate = json['creationDate'];
    skill = json['skill'];
    // members = json['members'] as List<String>;
    members = List.castFrom(json['members']).cast<String>();
    // categorys = json['categorys'];
    joiningDate = json['timestamp'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['picUrl'] = picUrl;
    data['createdBy'] = createdBy;
    data['creationDate'] = creationDate;
    data['timestamp'] = joiningDate;
    data['skill'] = skill;
    data['members'] = members;
    data['id'] = id;
    // data['categorys'] = categorys;
    return data;
  }
}

// {
//   "name":"name",
//   "picUrl":"pic",
//   "createdBy":"",
//   "creationDate":"",
//   "skill":"",
//   "members":{"":""}
//   "categorys":"name"
// }
import "package:cloud_firestore/cloud_firestore.dart";

class EventModel {
  EventModel({
    required this.title,
    required this.desc,
    required this.isOnline,
    required this.url,
    required this.creationDate,
    required this.venue,
  });
  late String title;
  late String desc;
  late bool isOnline;
  late String url;
  late int creationDate;
  late String venue;

  EventModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    isOnline = json['isOnline'];
    url = json['url'];
    creationDate = json['creationDate'];
    venue = json['venue'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['isOnline'] = isOnline;
    data['url'] = url;
    data['creationDate'] = creationDate;
    data['venue'] = venue;
    return data;
  }
}

// class EventModel {
//   String title = "";
//   String desc = "";
//   int time = 0;
//   bool isOnline = false;
//   String venue = "";
//   String url = "";
//   Timestamp creationDate = Timestamp.now();
// }


// {
//   "title":"",
//   "desc":"",
//   "desc":"awe",
//   "isOnline": true,
//   "url": "url",
//   "creationDate":3,
//   "venue":"we"
// }
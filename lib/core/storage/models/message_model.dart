class MessageModel {
  MessageModel({
    required this.message,
    required this.creationDate,
    required this.createdBy,
  });
  late final String message;
  late final int creationDate;
  late final String createdBy;

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    creationDate = json['creationDate'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['creationDate'] = creationDate;
    _data['createdBy'] = createdBy;
    return _data;
  }
}

// {
//   "message":"msg",
//   "creationDate":234,
//   "createdBy":"s",
  
// }
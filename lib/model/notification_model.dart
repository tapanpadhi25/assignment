class NotificationModel {
  String? message;
  List<NotificationModelData>? data;
  bool? success;

  NotificationModel({this.message, this.data, this.success});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    message = json['message']??"";
    if (json['data'] != null) {
      data = <NotificationModelData>[];
      json['data'].forEach((v) {
        data!.add(NotificationModelData.fromJson(v));
      });
    }
    success = json['success']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class NotificationModelData {
  String? image;
  String? title;
  String? body;
  String? timestamp;

  NotificationModelData({this.image, this.title, this.body, this.timestamp});

  NotificationModelData.fromJson(Map<String, dynamic> json) {
    image = json['image']??"";
    title = json['title']??"";
    body = json['body']??"";
    timestamp = json['timestamp']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['body'] = body;
    data['timestamp'] = timestamp;
    return data;
  }
}

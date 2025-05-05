class GetModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  GetModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  // Factory constructor to create a GetModel from JSON
  factory GetModel.fromJson(Map<String, dynamic> json) {
    return GetModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
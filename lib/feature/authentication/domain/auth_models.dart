class CustomResponse {
  String? message;
  bool? status;
  dynamic field;
  CustomResponse({
    required this.field,
    required this.message,
    required this.status,
  });

  factory CustomResponse.fromJson(
      {required Map<String, dynamic> json, required dynamic field}) {
    return CustomResponse(
      field: field,
      message: json['message'],
      status: json['success'],
    );
  }
}

class User {
  int? id;
  String? name;
  String? image;
  int? age;

  User({
    required this.age,
    required this.id,
    required this.image,
    required this.name,
  });
}

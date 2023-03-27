// To parse this JSON data, do
//
//     final errorModels = errorModelsFromJson(jsonString);

import '../../../component/import_file/import_data.dart';

ErrorModels errorModelsFromJson(String str) =>
    ErrorModels.fromJson(json.decode(str));

String errorModelsToJson(ErrorModels data) => json.encode(data.toJson());

class ErrorModels {
  ErrorModels({
    required this.status,
    required this.code,
    required this.message,
  });

  String status;
  String code;
  String message;

  factory ErrorModels.fromJson(Map<String, dynamic> json) => ErrorModels(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}

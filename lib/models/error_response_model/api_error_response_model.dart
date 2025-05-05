import 'package:json_annotation/json_annotation.dart';
part 'api_error_response_model.g.dart';

//flutter pub run build_runner build --delete-conflicting-outputs

@JsonSerializable()
class ApiErrorResponseModel{
  bool? success;
  String? message;

  ApiErrorResponseModel({this.success, this.message});

  factory ApiErrorResponseModel.fromJson(Map<String, dynamic> json) => _$ApiErrorResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorResponseModelToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorResponseModel _$ApiErrorResponseModelFromJson(
        Map<String, dynamic> json) =>
    ApiErrorResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApiErrorResponseModelToJson(
        ApiErrorResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

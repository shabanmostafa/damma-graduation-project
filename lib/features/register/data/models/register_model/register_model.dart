import 'package:damma_project/features/register/data/models/register_model/errors.dart';

class RegisterModel {
  final String? type;
  final String? title; // Will contain success message
  final int? status;
  final Errors? errors;
  final String? traceId;

  RegisterModel({
    this.type,
    this.title,
    this.status,
    this.errors,
    this.traceId,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        type: json['type'] as String?,
        title: json['title'] as String?,
        status: json['status'] as int?,
        errors: json['errors'] != null
            ? Errors.fromJson(json['errors'] as Map<String, dynamic>)
            : null,
        traceId: json['traceId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title,
        'status': status,
        'errors': errors?.toJson(),
        'traceId': traceId,
      };
}

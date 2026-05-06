// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:json_annotation/json_annotation.dart';

part 'return_config_spec.g.dart';

/// The Config associated with this Chat.
@JsonSerializable()
class ReturnConfigSpec {
  const ReturnConfigSpec({
    required this.id,
    required this.version,
  });
  
  factory ReturnConfigSpec.fromJson(Map<String, Object?> json) => _$ReturnConfigSpecFromJson(json);
  
  /// Identifier for a Config. Formatted as a UUID.
  final String id;

  /// Version number for a Config.
  ///
  /// Configs, Prompts, Custom Voices, and Tools are versioned. This versioning system supports iterative development, allowing you to progressively refine configurations and revert to previous versions if needed.
  ///
  /// Version numbers are integer values representing different iterations of the Config. Each update to the Config increments its version number.
  final int? version;

  Map<String, Object?> toJson() => _$ReturnConfigSpecToJson(this);
}

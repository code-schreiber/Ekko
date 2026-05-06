// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';

import 'subpackage_chats/subpackage_chats_client.dart';

/// empathic-voice-interface `v1.0.0`
class RestClient {
  RestClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.0.0';

  SubpackageChatsClient? _subpackageChats;

  SubpackageChatsClient get subpackageChats => _subpackageChats ??= SubpackageChatsClient(_dio, baseUrl: _baseUrl);
}

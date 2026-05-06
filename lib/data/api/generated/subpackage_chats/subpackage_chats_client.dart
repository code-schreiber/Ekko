// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/return_chat_paged_events.dart';

part 'subpackage_chats_client.g.dart';

@RestApi()
abstract class SubpackageChatsClient {
  factory SubpackageChatsClient(Dio dio, {String? baseUrl}) = _SubpackageChatsClient;

  /// List chat events.
  ///
  /// Fetches a paginated list of **Chat** events.
  ///
  /// [id] - Identifier for a Chat. Formatted as a UUID.
  ///
  /// [pageSize] - Specifies the maximum number of results to include per page, enabling pagination. The value must be between 1 and 100, inclusive.
  ///
  /// For example, if `page_size` is set to 10, each page will include `up to 10 items. Defaults to 10.
  ///
  /// [pageNumber] - Specifies the page number to retrieve, enabling pagination.
  ///
  /// This parameter uses zero-based indexing. For example, setting `page_number` to 0 retrieves the first page of results (items 0-9 if `page_size` is 10), setting `page_number` to 1 retrieves the second page (items 10-19), and so on. Defaults to 0, which retrieves the first page.
  ///
  /// [ascendingOrder] - Specifies the sorting order of the results based on their creation date. Set to true for ascending order (chronological, with the oldest records first) and false for descending order (reverse-chronological, with the newest records first). Defaults to true.
  @GET('/v0/evi/chats/{id}')
  Future<ReturnChatPagedEvents> listChatEvents({
    @Path('id') required String id,
    @Header('X-Hume-Api-Key') required String xHumeApiKey,
    @Query('page_number') int pageNumber = 0,
    @Query('page_size') int? pageSize,
    @Query('ascending_order') bool? ascendingOrder,
  });
}

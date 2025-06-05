// features/add_post/data/repo/post_repo_impl.dart

import 'dart:io';

import 'package:damma_project/features/add_post/data/repo/post_repo.dart';
import 'package:dio/dio.dart';
import '../../../../core/utils/api/api_consumer.dart';
import '../../../../core/utils/api/endpoints.dart';
import '../models/add_post_model.dart';

class PostRepoImpl implements PostRepo {
  final ApiConsumer api;

  PostRepoImpl(this.api);

  @override
  Future<String> addPost(AddPostModel post) async {
    try {
      final response = await api.post(
        Endpoints.addPost,
        data: post.toJson(),
        isFromData: true,
      );

      if (response is String && response.contains("max create successfully")) {
        return response;
      } else if (response is Map && response.containsKey('message')) {
        return response['message'];
      }

      return "Post created successfully";
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        throw Exception("Invalid post data");
      } else if (e.response != null && e.response!.statusCode == 401) {
        throw Exception("Unauthorized");
      } else {
        throw Exception("Failed to create post: ${e.message}");
      }
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Failed to create post: $e");
    }
  }
}

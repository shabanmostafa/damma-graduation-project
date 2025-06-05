import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'package:damma_project/features/add_post/data/models/add_post_model.dart';
import 'package:damma_project/features/add_post/data/repo/post_repo.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // <<<<< add this line

class PostRepoImpl implements PostRepo {
  final ApiConsumer api;

  PostRepoImpl(this.api);

  @override
  Future<String> addPost(AddPostModel post) async {
    try {
      final formData = FormData();

      // إضافة الحقول النصية
      formData.fields.addAll([
        MapEntry('Title', post.title),
        MapEntry('Content', post.content),
      ]);

      // إضافة ملف الصورة إذا كان موجوداً
      if (post.image != null) {
        formData.files.add(
          MapEntry(
            'Image',
            await MultipartFile.fromFile(
              post.image!.path,
              filename: 'image_${DateTime.now().millisecondsSinceEpoch}.jpg',
              contentType: MediaType('image', 'jpeg'),
            ),
          ),
        );
      }

      // إضافة ملف الفيديو إذا كان موجوداً
      if (post.video != null) {
        formData.files.add(
          MapEntry(
            'Video',
            await MultipartFile.fromFile(
              post.video!.path,
              filename: 'video_${DateTime.now().millisecondsSinceEpoch}.mp4',
              contentType: MediaType('video', 'mp4'),
            ),
          ),
        );
      }

      final response = await api.post(
        Endpoints.addPost,
        data: formData,
        isFromData: true,
      );

      if (response is String &&
          response.contains("Post created successfully")) {
        return response;
      } else if (response is Map && response.containsKey('message')) {
        return response['message'];
      }

      return "Post created successfully";
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 413) {
          throw Exception("حجم الملف كبير جداً");
        } else if (e.response!.statusCode == 415) {
          throw Exception("نوع الملف غير مدعوم");
        }
      }
      throw Exception("فشل إنشاء المنشور: ${e.message}");
    }
  }
}

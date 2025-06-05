import '../models/add_post_model.dart';

abstract class PostRepo {
  Future<String> addPost(AddPostModel post);
}

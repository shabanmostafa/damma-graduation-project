// features/post/data/models/add_post_model.dart

class AddPostModel {
  final String title;
  final String content;
  final String? image;
  final String? video;

  AddPostModel({
    required this.title,
    required this.content,
    this.image,
    this.video,
  });

  Map<String, dynamic> toJson() {
    return {
      'Title': title,
      'Content': content,
      'Image': image,
      'Video': video,
    };
  }
}

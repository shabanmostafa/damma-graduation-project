import 'package:image_picker/image_picker.dart';

class AddPostModel {
  final String title;
  final String content;
  final XFile? image;
  final XFile? video;

  AddPostModel({
    required this.title,
    required this.content,
    this.image,
    this.video,
  });
}

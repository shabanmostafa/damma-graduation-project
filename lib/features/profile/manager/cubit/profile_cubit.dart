import 'package:damma_project/features/home/models/post_model.dart';
import 'package:damma_project/features/profile/manager/cubit/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  bool showAllPosts = false;

  List<PostModel> posts = [
    PostModel(
      postOwnerPic: 'assets/images/shaban.jpg',
      postOwnerName: 'Shabaan Mostafa',
      postOwnerfriends: '5,432 متابع',
      postImage: 'assets/images/shaban.jpg',
      postContent: 'شكرا لكل من ساهم في نجاح هذا العمل...',
      numberOfLikes: '0',
      numberOfComments: '0',
      numberOfShares: '120',
      userProfilePic: 'assets/images/shaban.jpg',
    ),
    PostModel(
      postOwnerPic: 'assets/images/shaban.jpg',
      postOwnerName: 'شعبان مصطفي',
      postOwnerfriends: '5,432 متابع',
      postImage: 'assets/images/shaban.jpg',
      postContent: 'من يسكن البحر ويحبه الناس لونه اصفر...',
      numberOfLikes: '12',
      numberOfComments: '0',
      numberOfShares: '120',
      userProfilePic: 'assets/images/shaban.jpg',
    ),
  ];

  void toggleShowAllPosts() {
    showAllPosts = true;
    emit(ProfileShowAllPosts());
  }
}

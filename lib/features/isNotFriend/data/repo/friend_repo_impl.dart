// import 'package:damma_project/core/utils/api/api_consumer.dart';
// import 'package:damma_project/core/utils/api/endpoints.dart';
// import 'package:dartz/dartz.dart';
// import 'friend_repo.dart';

// class FriendRepoImpl implements FriendRepo {
//   final ApiConsumer apiConsumer;

//   FriendRepoImpl(this.apiConsumer);

//   @override
//   Future<Either<String, void>> sendFriendRequest(int receiverId) async {
//     try {
//       await apiConsumer.post(
//         Endpoints.sendFriendRequest,
//         data: {'receiverId': receiverId},
//       );
//       return const Right(null);
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/core/utils/api/endpoints.dart';
import 'friend_repo.dart';

// class FriendRepoImpl implements FriendRepo {
//   final ApiConsumer apiConsumer;

//   FriendRepoImpl(this.apiConsumer);

//   @override
//   Future<Either<String, void>> sendFriendRequest(int receiverId) async {
//     try {
//       await apiConsumer.post(
//         Endpoints.sendFriendRequest,
//         data: {'receiverId': receiverId},
//       );
//       return const Right(null);
//     } catch (e) {
//       if (e is DioException && e.response != null) {
//         final message = e.response?.data['message']?.toString() ?? '';
//         if (message.contains('Friend request already exists.') ||
//             message.contains('مسبق')) {
//           return const Left('تم ارسال طلب الصداقة مسبقا');
//         }
//       }
//       return const Left('حدث خطأ أثناء إرسال الطلب');
//     }
//   }
// }

class FriendRepoImpl implements FriendRepo {
  final ApiConsumer apiConsumer;

  FriendRepoImpl(this.apiConsumer);

  @override
  Future<Either<String, void>> sendFriendRequest(int receiverId) async {
    try {
      await apiConsumer.post(
        Endpoints.sendFriendRequest,
        data: {'receiverId': receiverId},
      );
      return const Right(null);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message']?.toString() ?? '';

        if (statusCode == 400) {
          return const Left('تم ارسال طلب الصداقة مسبقا');
        }

        return Left(message.isNotEmpty ? message : 'حدث خطأ أثناء إرسال الطلب');
      }
      return const Left('حدث خطأ أثناء إرسال الطلب');
    }
  }
}

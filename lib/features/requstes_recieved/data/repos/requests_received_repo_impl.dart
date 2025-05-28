import 'package:damma_project/core/utils/api/api_consumer.dart';
import 'package:damma_project/features/requstes_recieved/data/models/pending_friends/pending_friends.dart';
import 'package:damma_project/features/requstes_recieved/data/repos/requests_received_repo.dart';

class RequestsReceivedRepoImpl implements RequestsReceivedRepo {
  final ApiConsumer apiConsumer;

  RequestsReceivedRepoImpl(this.apiConsumer);

  @override
  Future<PendingFriends> getReceivedRequests() async {
    final response = await apiConsumer.get('/Friends/requests/pending');
    return PendingFriends.fromJson(response);
  }

  @override
  Future<void> acceptRequest(int requestId) async {
    await apiConsumer.put('/Friends/requests/$requestId/accept');
  }

  @override
  Future<void> rejectRequest(int requestId) async {
    await apiConsumer.put('/Friends/requests/$requestId/reject');
  }
}

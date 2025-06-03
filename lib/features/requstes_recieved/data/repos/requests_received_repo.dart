import 'package:damma_project/features/requstes_recieved/data/models/pending_friends/pending_friends.dart';

abstract class RequestsReceivedRepo {
  Future<PendingFriends> getReceivedRequests();
  Future<void> acceptRequest(int requestId);
  Future<void> rejectRequest(int requestId);
}

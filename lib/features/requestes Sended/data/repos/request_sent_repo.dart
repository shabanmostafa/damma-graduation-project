import '../models/requested_sended_model/requested_sended_model.dart';

abstract class RequestSentRepo {
  Future<RequestedSendedModel> getSentRequests();
  Future<void> cancelRequest(int requestId);
}

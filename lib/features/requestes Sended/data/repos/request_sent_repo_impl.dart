import 'package:damma_project/core/utils/api/api_consumer.dart';

import '../models/requested_sended_model/requested_sended_model.dart'
    show RequestedSendedModel;
import 'request_sent_repo.dart';

class RequestSentRepoImpl implements RequestSentRepo {
  final ApiConsumer apiConsumer;

  RequestSentRepoImpl(this.apiConsumer);

  @override
  Future<RequestedSendedModel> getSentRequests() async {
    final response = await apiConsumer.get('/Friends/GetRequestsSended');
    return RequestedSendedModel.fromJson(response);
  }

  @override
  Future<void> cancelRequest(int requestId) async {
    await apiConsumer.put('/Friends/requests/$requestId/cancel');
  }
}

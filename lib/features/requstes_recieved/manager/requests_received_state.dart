part of 'requests_received_cubit.dart';

abstract class RequestsReceivedState {}

class RequestsReceivedInitial extends RequestsReceivedState {}

class RequestsReceivedLoading extends RequestsReceivedState {}

class RequestsReceivedSuccess extends RequestsReceivedState {
  final PendingFriends receivedRequests;

  RequestsReceivedSuccess(this.receivedRequests);
}

class RequestsReceivedFailure extends RequestsReceivedState {
  final String error;

  RequestsReceivedFailure(this.error);
}

class RequestAccepted extends RequestsReceivedState {
  final int requestId;

  RequestAccepted(this.requestId);
}

class RequestRejected extends RequestsReceivedState {
  final int requestId;

  RequestRejected(this.requestId);
}
